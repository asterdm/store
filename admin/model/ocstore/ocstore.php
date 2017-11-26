<?php
class ModelOcstoreOcstore extends Model{
	public function install() {
		$this->db->query("
				CREATE TABLE IF NOT EXISTS `" . DB_PREFIX . "ocstore_settings` (
					`ocstore_settings_id` INT(11) NOT NULL AUTO_INCREMENT,
					`key` VARCHAR(100) NOT NULL,
					`value` TEXT NOT NULL,
					PRIMARY KEY (`ocstore_settings_id`)
				) ENGINE=MyISAM  DEFAULT CHARSET=utf8;");

		$this->db->query("
				CREATE TABLE IF NOT EXISTS `" . DB_PREFIX . "ocstore_pickup` (
				  `ocstore_pickup_id` int(11) NOT NULL AUTO_INCREMENT,
				  `name` VARCHAR(255) NOT NULL,
				  `address` VARCHAR(255) NOT NULL,
				  `description` TEXT NOT NULL,
				  `worktime` VARCHAR(255) NOT NULL,
				  `phone` VARCHAR(255) NOT NULL,
				  `email` VARCHAR(255) NOT NULL,
				  `zone_id` int(11) NOT NULL,
				  `map_coordx` decimal(15, 10) NOT NULL,
				  `map_coordy` decimal(15, 10) NOT NULL,
				  `cost_delivery` decimal(15, 2) NOT NULL,
				  `min_order_sum` decimal(15, 2) NOT NULL,
				  `point_view` boolean NOT NULL,
				  `enable` boolean NOT NULL,
				  PRIMARY KEY (`ocstore_pickup_id`)
				) ENGINE=MyISAM  DEFAULT CHARSET=utf8;");

		$this->db->query("INSERT INTO `" . DB_PREFIX . "ocstore_settings` (`key`, `value`) VALUES ('pickup_country', '".$this->config->get("config_country_id")."')");
		$this->db->query("INSERT INTO `" . DB_PREFIX . "ocstore_settings` (`key`, `value`) VALUES ('pickup_maptype', 'yandex')");
		$this->db->query("INSERT INTO `" . DB_PREFIX . "ocstore_settings` (`key`, `value`) VALUES ('pickup_image', '/catalog/view/ocstore/images/pickup_map_marker.png')");
	}

	public function uninstall() {
	}


}