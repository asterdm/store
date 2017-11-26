<?php
class ModelShippingOcstorePickup extends Model {
	function getQuote($address) {
		$this->load->language('shipping/ocstore_pickup');

		$query = $this->db->query("SELECT p.*, z.name as zone_name FROM `" . DB_PREFIX . "ocstore_pickup` p, `" . DB_PREFIX . "zone` z WHERE p.zone_id=z.zone_id and p.enable=1 ". (isset($address['zone_id']) && $address['zone_id'] != ""? " and p.zone_id = " . (int) $address['zone_id']: ""));

		if (!$this->config->get('pickup_geo_zone_id')) {
			$status = true;
		} elseif ($query->num_rows) {
			$status = true;
		} else {
			$status = false;
		}

		$method_data = array();

		if ($status) {
			$quote_data = array();

			foreach ($query->rows as $row) {
				$quote_data[$row['ocstore_pickup_id']] = array(
					'code' => 'ocstore_pickup.'.$row['ocstore_pickup_id'],
					'title' => $row['name']." (".$row['zone_name'].", ".$row['address']."). ".$this->language->get('text_worktime').": ".$row['worktime'].". ".$this->language->get('text_phone').": ".$row['phone'].($row['email'] != ""? ", <a href='mailto:{$row['email']}'>{$row['email']}</a>": ""),
					'cost' => $row['cost_delivery'],
					'tax_class_id' => 0,
					'text' => $this->currency->format($row['cost_delivery'])
				);
			}

			$method_data = array(
				'code'       => 'ocstore_pickup',
				'title'      => $this->language->get('text_title'),
				'quote'      => $quote_data,
				'sort_order' => $this->config->get('pickup_sort_order'),
				'error'      => false
			);
		}

		return $method_data;
	}
}