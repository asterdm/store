<?php
class Ocstore extends Model{
	protected $registry;

	public function __construct($registry) {
		$this->registry = $registry;
	}
	
	public function get($key) {
		return $this->db->query("select `value` from `" . DB_PREFIX . "ocstore_settings` where `key` = '".$this->db->escape($key)."';")->row['value'];
	}

	public function set($key, $value) {
		return $this->db->query("update`" . DB_PREFIX . "ocstore_settings` set `value` = '".$this->db->escape($value)."' where `key` = '".$this->db->escape($key)."';");
	}
}

class OcstoreException extends Exception
{
	public function __construct($message, $code = 0, Exception $previous = null) {
		parent::__construct($message, $code, $previous);
	}

	public function __toString() {
		return __CLASS__ . ": [{$this->code}]: {$this->message}\n";
	}
}

class ModelOcstorePickup extends Ocstore {
    public function getPoints($page = 1, $filter = array()) {
        $sql = "SHOW TABLES LIKE '" . DB_PREFIX . "ocstore_pickup'";
        if (count($this->db->query($sql)->rows) == 0) {
            $this->load->language('shipping/ocstore_pickup');
            throw new OcstoreException($this->language->get('exception_module_not_installed'), 1);
        }

        $sql = "select p.*, z.name as zone_name from `" . DB_PREFIX . "ocstore_pickup` p, `" . DB_PREFIX . "zone` z where p.zone_id = z.zone_id ";
        if (isset($filter['ocstore_pickup_name']) && trim($filter['ocstore_pickup_name']) != "")
            $sql .= " and p.name like '%".$this->db->escape($filter['ocstore_pickup_name'])."%'";
        if (isset($filter['ocstore_pickup_zone']) && trim($filter['ocstore_pickup_zone']) != "")
            $sql .= " and p.zone_id = ".((int) $filter['ocstore_pickup_zone']);
        if (isset($filter['ocstore_pickup_address']) && trim($filter['ocstore_pickup_address']) != "")
            $sql .= " and p.address like '%".$this->db->escape($filter['ocstore_pickup_address'])."%'";
        if (isset($filter['ocstore_pickup_worktime']) && trim($filter['ocstore_pickup_worktime']) != "")
            $sql .= " and p.address like '%".$this->db->escape($filter['ocstore_pickup_worktime'])."%'";
        if (isset($filter['ocstore_pickup_enable']) && trim($filter['ocstore_pickup_enable']) != -1)
            $sql .= " and p.enable = ".((int) $filter['ocstore_pickup_enable']);

        if ($page < 1)
            $page = 1;
        $sql .= " limit ".($this->config->get("config_limit_admin")*($page - 1)).", ".$this->config->get("config_limit_admin");

        return $this->db->query($sql)->rows;
    }

    public function edit($id)
    {
        if (!is_numeric($id))
            throw new OcstoreException($this->language->get('exception_point_not_found'), 2);

        $sql = "select * from `" . DB_PREFIX . "ocstore_pickup` where ocstore_pickup_id = ".$id." limit 1";
        $point = $this->db->query($sql)->row;

        if (!empty($point) && count($point) > 0)
            return $point;

        throw new OcstoreException($this->language->get('exception_point_not_found'), 2);
    }

    public function update($id, $post) {
        $temp = array();
        foreach ($post as $key => $value)
            $temp[] = "`".str_replace("ocstore_pickup_", "", $key)."` = '".$this->db->escape($value)."'";
        $sql = "update `" . DB_PREFIX . "ocstore_pickup` set ".implode(", ", $temp)." where ocstore_pickup_id = ".$id;
        $this->db->query($sql);

        unset($temp);
    }

    public function save($post) {
        $keys = array(); $values = array();

        foreach ($post as $key => $value) {
            $keys[] = "`" . str_replace("ocstore_pickup_", "", $key) . "`";
            $values[] = "'" . $this->db->escape($value) . "'";
        }
        $sql = "insert into `" . DB_PREFIX . "ocstore_pickup` (".implode(", ", $keys).") VALUES (".implode(", ", $values).");";
        $this->db->query($sql);

        unset($keys); unset($values);
    }

    public function add() {
        return array(
            "name"          => "",
            "address"       => "",
            "description"   => "",
            "worktime"      => "",
            "phone"         => "",
            "email"         => "",
            "zone_id"       => $this->config->get("config_zone_id"),
            "cost_delivery" => "0.00",
            "enable"        => 1
        );
    }
}