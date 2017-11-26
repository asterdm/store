<?php
class Modelpaymenttinkoff extends Model {
    public function getMethod($address, $total) {
        $this->language->load('payment/tinkoff');

        return array(
            'code'       => 'tinkoff',
            'terms' => "",
            'title'      => $this->language->get('text_title'),
            'sort_order' => $this->config->get('tinkoff_sort_order')
        );
    }

    /**
     * After calling initPayment()
     */
    const STATUS_NEW = 'NEW';

    /**
     * After calling cancelPayment()
     * Not Implemented here
     */
    const STATUS_CANCELED = 'CANCELED';

    /**
     * Intermediate status (transaction is in process)
     */
    const STATUS_PREAUTHORIZING = 'PREAUTHORIZING';

    /**
     * After showing payment form to the customer
     */
    const STATUS_FORMSHOWED = 'FORMSHOWED';

    /**
     * Intermediate status (transaction is in process)
     */
    const STATUS_AUTHORIZING = 'AUTHORIZING';

    /**
     * Intermediate status (transaction is in process)
     * Customer went to 3DS
     */
    const STATUS_THREEDSCHECKING = 'THREEDSCHECKING';

    /**
     * Payment rejected on 3DS
     */
    const STATUS_REJECTED = 'REJECTED';

    /**
     * Payment compete, money holded
     */
    const STATUS_AUTHORIZED = 'AUTHORIZED';

    /**
     * After calling reversePayment
     * Charge money back to customer
     * Not Implemented here
     */
    const STATUS_REVERSING = 'REVERSING';

    /**
     * Money charged back, transaction cmplete
     */
    const STATUS_REVERSED = 'REVERSED';

    /**
     * After calling confirmePayment()
     * Confirm money wright-off
     * Not Implemented here
     */
    const STATUS_CONFIRMING = 'CONFIRMING';

    /**
     * Money written off
     */
    const STATUS_CONFIRMED = 'CONFIRMED';

    /**
     * After calling refundPayment()
     * Retrive money back to customer
     * Not Implemented here
     */
    const STATUS_REFUNDING = 'REFUNDING';

    /**
     * Money is back on the customer account
     */
    const STATUS_REFUNDED = 'REFUNDED';

    const STATUS_UNKNOWN = 'UNKNOWN';

    /**
     * Terminal id, bank give it to you
     * @var int
     */
    private $terminalId;

    /**
     * Secret key, bank give it to you
     * @var string
     */
    private $secret;

    /**
     * Read API documentation
     * @var string
     */
    private $paymentUrl;

    /**
     * Current payment status
     * @var string
     */
    private $paymentStatus;

    /**
     * Payment id in bank system
     * @var int
     */
    private $paymentId;

    /**
     * Валята заказа (643 - рубли)
     * @var int
     */
    private $currency = 643;

    public function __construct($registry){
        parent::__construct($registry);

        $this->terminalId = $this->config->get('tinkoff_terminal_key');
        $this->secret = $this->config->get('tinkoff_secret_key');
        $url = $this->config->get('tinkoff_payment_url');
        if ($url[strlen($url)-1]==='/') {
            $this->paymentUrl = substr($url, 0, -1);
        } else {
            $this->paymentUrl = $url;
        }
        $this->currency = $this->config->get('currency');
    }

    /**
     * Return payment link for user redirection and params for it
     *
     * @param array $params
     * @return array
     * @throws TinkoffException
     */
    public function initPayment(array $params) {
        $requestParams = array(
            'TerminalKey' => $this->terminalId,
            'Amount' => (int) $params['amount'],
            'OrderId' => $params['orderId'],
        );
        $requestParams['Token'] = $this->generateToken($requestParams);

        $url = sprintf('%s/Init?%s', $this->paymentUrl, http_build_query($requestParams));

        $resultString = @file_get_contents($url);

        if(!$this->isJson($resultString)){
            die('не удалось соединиться с платёжным сервисом');
        }

        $result = json_decode($resultString, true);

        if($result['ErrorCode']==8){
            die($result['Details']);
        }
        $this->isRequestSuccess($result['Success']);

        $url = parse_url($result['PaymentURL']);

        $urlParams = array();

        //parse_str($url['query'], $urlParams);

        $this->paymentStatus = $result['Status'];
        $this->paymentId = $result['PaymentId'];

        $this->saveOrder($params['orderId']);

        return array(
            'url' => $result['PaymentURL'],
            'params' => $urlParams,
        );
    }

    /**
     * Check if order is complete and money paid
     *
     * @return bool
     * @throws TinkoffException
     */
    public function isOrderPaid(){
        $this->checkStatus();

        return in_array($this->paymentStatus, array(self::STATUS_CONFIRMED, self::STATUS_AUTHORIZED));
    }

    /**
     * Checks if oreder is failed
     *
     * @return bool
     */
    public function isOrderFailed(){
        return in_array($this->paymentStatus, array(self::STATUS_CANCELED, self::STATUS_REJECTED, self::STATUS_REVERSED));
    }

    public function saveOrder($orderId){
        $date = new \DateTime();

        $currentDate = $date->format('Y-m-d h:i:s');

        $orders = $this->db->query("
          SELECT `id`
          FROM " . DB_PREFIX . "tinkoff_payments
          WHERE `order_id` = '" .(int)$orderId . "'");

        if($orders->num_rows > 0){
            $this->db->query("
			    UPDATE " . DB_PREFIX . "tinkoff_payments
			    SET payment_id = '" . $this->paymentId . "',
				    updated = '" . $currentDate . "',
				    status = '" . $this->paymentStatus . "'
			    WHERE order_id = " . (int)$orderId
            );

            return true;
        }

        $this->db->query("
            INSERT INTO `" . DB_PREFIX . "tinkoff_payments`
            SET order_id = '" .(int)$orderId . "',
			    payment_id = '" . $this->paymentId . "',
			    created = '" . $currentDate . "',
				updated = '" . $currentDate . "',
				status = '" . $this->paymentStatus . "'
        ");

        return true;
    }

    /**
     * Check is status variable is set
     *
     * @throws TinkoffException
     */
    private function checkStatus(){
        if(is_null($this->paymentStatus)){
            throw new TinkoffException(sprintf('Статус заказа не определён. Чтобы запросить статус вызовите метод getStatus'));
        }

    }

    /**
     * Check bank response format
     *
     * @param $string
     * @return bool
     */
    private function isJson($string) {
        json_decode($string);

        return (json_last_error() == JSON_ERROR_NONE);
    }

    /**
     * Generates request signature
     *
     * @param array $params
     * @return string
     */
    private function generateToken(array $params){
        $requestParams = $params;
        $requestParams['Password'] = $this->secret;

        ksort($requestParams);

        $values = implode('', array_values($requestParams));

        return hash('sha256', $values);
    }

    /**
     * Checks request success
     *
     * @param $success
     * @throws TinkoffException
     */
    private function isRequestSuccess($success){
        if($success == false){
            die(sprintf('Зарпос к сервису ТКС провален'));
        }
    }
}

/**
 * Class TinkoffException
 */
class TinkoffException extends Exception {

}