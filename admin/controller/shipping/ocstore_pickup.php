<?php
class ControllerShippingOcstorePickup extends Controller {
	private $error = array();

	public function install() {
		$this->load->model('ocstore/ocstore');

		$this->model_user_user_group->addPermission($this->user->getGroupId(), 'modify', 'shipping/ocstore_pickup');
		$this->model_user_user_group->addPermission($this->user->getGroupId(), 'access', 'shipping/ocstore_pickup');

		$this->model_ocstore_ocstore->install();
	}

	public function uninstall() {
		$this->load->model('ocstore/ocstore');
		$this->model_ocstore_ocstore->uninstall();
	}

	public function index() {
		$this->load->language('shipping/ocstore_pickup');
		$this->load->model('ocstore/ocstore');
		$this->load->model('ocstore/pickup');
		$this->load->model('localisation/country');

		if ($this->request->server['REQUEST_METHOD'] == 'POST') {
			$this->model_ocstore_pickup->set("pickup_maptype", $this->request->post['ocstore_pickup_maptype']);
			if ($this->request->post['ocstore_pickup_image'] == "")
				$this->request->post['ocstore_pickup_image'] = "/catalog/view/ocstore/images/pickup_map_marker.png";
			$this->model_ocstore_pickup->set("pickup_image", $this->request->post['ocstore_pickup_image']);
			$this->model_ocstore_pickup->set("pickup_country", $this->request->post['ocstore_pickup_country']);

			$this->load->model('setting/setting');
			$this->model_setting_setting->editSetting('ocstore_pickup', array("ocstore_pickup_status" => $this->request->post['ocstore_pickup_status']));
		}

		$data['heading_title'] = $this->language->get('heading_title');
		$data['ocstore_header'] = $this->language->get('ocstore_header');

		$data['entry_map_type'] = $this->language->get('entry_map_type');
		$data['entry_map_icon'] = $this->language->get('entry_map_icon');
		$data['entry_country'] = $this->language->get('entry_country');
		$data['entry_enabled'] = $this->language->get('entry_enabled');
		$data['entry_disabled'] = $this->language->get('entry_disabled');
		$data['entry_points_enable'] = $this->language->get('entry_points_enable');

		$data['ocstore_pickup_maptype'] = $this->model_ocstore_pickup->get("pickup_maptype");
		if ($data['ocstore_pickup_maptype'] === null)
			$data['ocstore_pickup_maptype'] = "yandex";
		$data['ocstore_pickup_maptypes'] = array(
			"yandex"	=> $this->language->get('entry_map_type_yandex'),
			"google"	=> $this->language->get('entry_map_type_google'),
		);
		$data['ocstore_pickup_image'] = $this->model_ocstore_pickup->get("pickup_image");
		$data['ocstore_pickup_country'] = $this->model_ocstore_pickup->get("pickup_country");
		$data['ocstore_pickup_status'] = $this->config->get("ocstore_pickup_status");
		$data['countries'] = $this->model_localisation_country->getCountries();

		$data['action'] = $this->url->link('shipping/ocstore_pickup', 'token=' . $this->session->data['token'], 'SSL');
		$data['cancel'] = $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL');

		$data['button_save'] = $this->language->get('button_save');
		$data['button_cancel'] = $this->language->get('button_cancel');
		$data['button_config'] = $this->language->get('button_config');
		$data['button_points'] = $this->language->get('button_points');
		$data['button_io'] = $this->language->get('button_io');

		$data['link_config'] = $this->url->link('shipping/ocstore_pickup', 'token=' . $this->session->data['token'], 'SSL');
		$data['link_points'] = $this->url->link('shipping/ocstore_pickup/points', 'token=' . $this->session->data['token'], 'SSL');
		$data['link_io'] = $this->url->link('shipping/ocstore_pickup/export_import', 'token=' . $this->session->data['token'], 'SSL');

		$data['token'] = $this->session->data['token'];

		$data['breadcrumbs'] = array();

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_home'),
			'href' => $this->url->link('common/dashboard', 'token=' . $this->session->data['token'], 'SSL')
		);

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_shipping'),
			'href' => $this->url->link('extension/shipping', 'token=' . $this->session->data['token'], 'SSL')
		);

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('heading_title'),
			'href' => $this->url->link('module/ocstore_pickup', 'token=' . $this->session->data['token'], 'SSL')
		);


		$data['header'] = $this->load->controller('common/header');
		$data['column_left'] = $this->load->controller('common/column_left');
		$data['footer'] = $this->load->controller('common/footer');

		$this->response->setOutput($this->load->view('ocstore/modules/pickup/configurate.tpl', $data));
	}

	public function points() {
		$this->load->language('shipping/ocstore_pickup');
		$this->load->model('ocstore/pickup');

		if ($this->request->server['REQUEST_METHOD'] == 'POST') {

		}

		$data['heading_title'] = $this->language->get('heading_title');
		$data['ocstore_header'] = $this->language->get('ocstore_header');

		$data['entry_points_name'] = $this->language->get('entry_points_name');
		$data['entry_points_zone'] = $this->language->get('entry_points_zone');
		$data['entry_points_address'] = $this->language->get('entry_points_address');
		$data['entry_points_worktime'] = $this->language->get('entry_points_worktime');
		$data['entry_points_enable'] = $this->language->get('entry_points_enable');
		$data['entry_active_unknown'] = $this->language->get('entry_active_unknown');
		$data['entry_enabled'] = $this->language->get('entry_enabled');
		$data['entry_disabled'] = $this->language->get('entry_disabled');

		$data['action'] = $this->url->link('shipping/ocstore_pickup/points', 'token=' . $this->session->data['token'], 'SSL');
		$data['cancel'] = $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL');

		$data['button_save'] = $this->language->get('button_save');
		$data['button_cancel'] = $this->language->get('button_cancel');
		$data['button_config'] = $this->language->get('button_config');
		$data['button_points'] = $this->language->get('button_points');
		$data['button_io'] = $this->language->get('button_io');
		$data['button_add'] = $this->language->get('button_add');
		$data['button_apply'] = $this->language->get('button_apply');
		$data['button_edit'] = $this->language->get('button_edit');
		$data['button_remove'] = $this->language->get('button_remove');

		$data['link_config'] = $this->url->link('shipping/ocstore_pickup', 'token=' . $this->session->data['token'], 'SSL');
		$data['link_points'] = $this->url->link('shipping/ocstore_pickup/points', 'token=' . $this->session->data['token'], 'SSL');
		$data['link_add'] = $this->url->link('shipping/ocstore_pickup/point_edit', 'token=' . $this->session->data['token'], 'SSL');
		$data['link_io'] = $this->url->link('shipping/ocstore_pickup/export_import', 'token=' . $this->session->data['token'], 'SSL');

		$data['token'] = $this->session->data['token'];

		$data['breadcrumbs'] = array();

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_home'),
			'href' => $this->url->link('common/dashboard', 'token=' . $this->session->data['token'], 'SSL')
		);

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_shipping'),
			'href' => $this->url->link('extension/shipping', 'token=' . $this->session->data['token'], 'SSL')
		);

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('heading_title'),
			'href' => $this->url->link('module/ocstore_pickup', 'token=' . $this->session->data['token'], 'SSL')
		);

		$filter = array();
		if ($this->request->server['REQUEST_METHOD'] == 'POST') {
			$filter = $this->request->post['filter'];
		}
		elseif ($this->request->server['REQUEST_METHOD'] == 'GET' && isset($this->request->get['filter'])) {
			$filter = $this->request->get['filter'];
		}

		$page = 1;
		if (isset($this->request->get['page']) && is_numeric($this->request->get['page']))
			$page = $this->request->get['page'];

		if (isset($this->session->data['error']) && $this->session->data['error'] != "") {
			$data['error'] = $this->session->data['error'];
			$this->session->data['error'] = "";
		}

		if (isset($this->session->data['success']) && $this->session->data['success'] != "") {
			$data['success'] = $this->session->data['success'];
			$this->session->data['success'] = "";
		}

		$data['points'] = $this->model_ocstore_pickup->getPoints($page, $filter);
		$data['filter'] = $filter;

		$data['link_edit'] = $this->url->link('shipping/ocstore_pickup/point_edit', 'token=' . $this->session->data['token'].'&'.http_build_query($filter)."&page=".$page, 'SSL');
		$data['link_remove'] = $this->url->link('shipping/ocstore_pickup/point_remove', 'token=' . $this->session->data['token'].'&'.http_build_query($filter)."&page=".$page, 'SSL');


		$data['header'] = $this->load->controller('common/header');
		$data['column_left'] = $this->load->controller('common/column_left');
		$data['footer'] = $this->load->controller('common/footer');

		$this->response->setOutput($this->load->view('ocstore/modules/pickup/points.tpl', $data));
	}

	public function point_edit() {
		$this->load->language('shipping/ocstore_pickup');
		$this->load->model('ocstore/pickup');
		$this->load->model('localisation/zone');

		if ($this->request->server['REQUEST_METHOD'] == 'POST' && $this->validateForm()) {
			if (isset($this->request->get['pickup_id'])) {
				$this->model_ocstore_pickup->update($this->request->get['pickup_id'], $this->request->post);
				$this->session->data['success'] = $this->language->get('success_update');
			}
			else {
				$this->model_ocstore_pickup->save($this->request->post);
				$this->session->data['success'] = $this->language->get('success_save');
			}
			$this->response->redirect($this->url->link('shipping/ocstore_pickup/points', 'token=' . $this->session->data['token'].(isset($this->request->get['filter'])? '&'.http_build_query($this->request->get['filter']): ""), 'SSL'));
		}

		try {
			if (isset($this->request->get['pickup_id']))
				$edit = $this->model_ocstore_pickup->edit($this->request->get['pickup_id']);
			else
				$edit = $this->model_ocstore_pickup->add();
		} catch (Exception $e) {
			$this->session->data['error'] = $e;
			$this->response->irect($this->url->link('shipping/ocstore_pickup/points', 'token=' . $this->session->data['token'].(isset($this->request->get['filter'])? '&'.http_build_query($this->request->get['filter']): ""), 'SSL'));
		}

		$data['heading_title'] = $this->language->get('heading_title');
		$data['ocstore_header'] = $this->language->get('ocstore_header');

		$data['action'] = $this->url->link('shipping/ocstore_pickup/point_edit', 'token=' . $this->session->data['token'].(isset($this->request->get['pickup_id'])? "&pickup_id=".$this->request->get['pickup_id']: ""), 'SSL');
		$data['cancel'] = $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL');

		$data['button_save'] = $this->language->get('button_save');
		$data['button_cancel'] = $this->language->get('button_cancel');
		$data['button_config'] = $this->language->get('button_config');
		$data['button_points'] = $this->language->get('button_points');
		$data['button_io'] = $this->language->get('button_io');

		$data['link_config'] = $this->url->link('shipping/ocstore_pickup', 'token=' . $this->session->data['token'], 'SSL');
		$data['link_points'] = $this->url->link('shipping/ocstore_pickup/points', 'token=' . $this->session->data['token'], 'SSL');
		$data['link_io'] = $this->url->link('shipping/ocstore_pickup/export_import', 'token=' . $this->session->data['token'], 'SSL');

		$data['token'] = $this->session->data['token'];

		$data['breadcrumbs'] = array();

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_home'),
			'href' => $this->url->link('common/dashboard', 'token=' . $this->session->data['token'], 'SSL')
		);

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_shipping'),
			'href' => $this->url->link('extension/shipping', 'token=' . $this->session->data['token'], 'SSL')
		);

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('heading_title'),
			'href' => $this->url->link('module/ocstore_pickup', 'token=' . $this->session->data['token'], 'SSL')
		);

		$data['breadcrumbs'][] = array(
			'text' => (isset($this->request->get['pickup_id'])? $edit['name']: "Добавление"),
			'href' => $this->url->link('module/ocstore_pickup/point_edit', 'token=' . $this->session->data['token'].(isset($this->request->get['pickup_id'])? '&pickup_id='.$edit['ocstore_pickup_id']: ""), 'SSL')
		);

		$data['entry_points_name'] = $this->language->get('entry_points_name');
		$data['entry_points_address'] = $this->language->get('entry_points_address');
		$data['entry_points_description'] = $this->language->get('entry_points_description');
		$data['entry_points_worktime'] = $this->language->get('entry_points_worktime');
		$data['entry_points_email'] = $this->language->get('entry_points_email');
		$data['entry_points_phone'] = $this->language->get('entry_points_phone');
		$data['entry_points_zone'] = $this->language->get('entry_points_zone');
		$data['entry_points_cost_delivery'] = $this->language->get('entry_points_cost_delivery');
		$data['entry_points_enable'] = $this->language->get('entry_points_enable');
		$data['entry_points_enable_enable'] = $this->language->get('entry_enabled');
		$data['entry_points_enable_disable'] = $this->language->get('entry_disabled');

		// data pickup point
		$data['ocstore_pickup_name'] = $edit['name'];
		$data['ocstore_pickup_address'] = $edit['address'];
		$data['ocstore_pickup_description'] = $edit['description'];
		$data['ocstore_pickup_worktime'] = $edit['worktime'];
		$data['ocstore_pickup_email'] = $edit['email'];
		$data['ocstore_pickup_phone'] = $edit['phone'];
		$data['ocstore_pickup_zone_id'] = $edit['zone_id'];
		$data['ocstore_pickup_zones'] = $this->model_localisation_zone->getZonesByCountryId($this->model_ocstore_pickup->get("pickup_country"));
		$data['ocstore_pickup_cost_delivery'] = $edit['cost_delivery'];
		$data['ocstore_pickup_enable'] = $edit['enable'];

		if (isset($this->session->data['olddata'])) {
			foreach ($this->session->data['olddata'] as $key => $value)
				$data[$key] = $value;
			unset($this->session->data['olddata']);
		}

		if (isset($this->session->data['errors'])) {
			$data['errors'] = $this->session->data['errors'];
			unset($this->session->data['errors']);
		}
		else
			$data['errors'] = array();

		if (isset($this->session->data['error'])) {
			$data['error'] = $this->session->data['error'];
			unset($this->session->data['error']);
		}



		$data['header'] = $this->load->controller('common/header');
		$data['column_left'] = $this->load->controller('common/column_left');
		$data['footer'] = $this->load->controller('common/footer');

		$this->response->setOutput($this->load->view('ocstore/modules/pickup/point_edit.tpl', $data));
	}

	private function validateForm() {
		try {
			$this->load->model('localisation/zone');

			$errors = array();

			if (!$this->user->hasPermission('modify', 'shipping/ocstore_pickup'))
				$errors["persimission"] = $this->language->get('error_permission');
			if (!isset($this->request->post['ocstore_pickup_name']) || mb_strlen(trim($this->request->post['ocstore_pickup_name'])) == 0 || mb_strlen(trim($this->request->post['ocstore_pickup_name'])) > 255)
				$errors["ocstore_pickup_name"] = $this->language->get('error_name');
			if (!isset($this->request->post['ocstore_pickup_address']) || mb_strlen(trim($this->request->post['ocstore_pickup_address'])) == 0 || mb_strlen(trim($this->request->post['ocstore_pickup_address'])) > 255)
				$errors["ocstore_pickup_address"] = $this->language->get('error_address');
			if (!isset($this->request->post['ocstore_pickup_worktime']) || mb_strlen(trim($this->request->post['ocstore_pickup_worktime'])) == 0 || mb_strlen(trim($this->request->post['ocstore_pickup_worktime'])) > 255)
				$errors["ocstore_pickup_worktime"] = $this->language->get('error_worktime');
			if (!isset($this->request->post['ocstore_pickup_phone']) || mb_strlen(trim($this->request->post['ocstore_pickup_phone'])) == 0 || mb_strlen(trim($this->request->post['ocstore_pickup_phone'])) > 255)
				$errors["ocstore_pickup_phone"] = $this->language->get('error_phone');
			if (!isset($this->request->post['ocstore_pickup_email']) || (mb_strlen(trim($this->request->post['ocstore_pickup_email'])) != 0 && !filter_var($this->request->post['ocstore_pickup_email'], FILTER_VALIDATE_EMAIL)))
				$errors["ocstore_pickup_email"] = $this->language->get('error_email');
			if (!isset($this->request->post['ocstore_pickup_zone_id']) || $this->model_localisation_zone->getZone($this->request->post['ocstore_pickup_zone_id']) === array())
				$errors["ocstore_pickup_zone_id"] = $this->language->get('error_zone');
			if (!isset($this->request->post['ocstore_pickup_cost_delivery']) || mb_strlen(trim($this->request->post['ocstore_pickup_cost_delivery'])) == 0 || !is_numeric($this->request->post['ocstore_pickup_cost_delivery']))
				$errors["ocstore_pickup_cost_delivery"] = $this->language->get('error_cost_delivery');
			if (!isset($this->request->post['ocstore_pickup_enable']) || !in_array($this->request->post['ocstore_pickup_enable'], array("0", "1")))
				$errors["ocstore_pickup_enable"] = $this->language->get('error_enable');

			if ($errors !== array()) {
				$this->session->data['errors'] = $errors;
				throw new OcstoreException($this->language->get('exception_validate'), 3);
			}
		} catch (OcstoreException $e) {
			$this->session->data['error'] = (string) $e;
			$this->session->data['olddata'] = $this->request->post;
			unset($this->request->get['route']);
			$this->response->redirect($this->url->link('shipping/ocstore_pickup/point_edit', http_build_query($this->request->get), 'SSL'));
		}

		return true;
	}

	public function export_import() {
		$this->load->language('shipping/ocstore_pickup');

		$data['heading_title'] = $this->language->get('heading_title');
		$data['ocstore_header'] = $this->language->get('ocstore_header');

		$data['text_error'] = $this->language->get('text_error');
		$data['text_access_denied'] = $this->language->get('text_access_denied');

		$data['action'] = $this->url->link('shipping/ocstore_pickup', 'token=' . $this->session->data['token'], 'SSL');
		$data['cancel'] = $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL');

		$data['button_save'] = $this->language->get('button_save');
		$data['button_cancel'] = $this->language->get('button_cancel');
		$data['button_config'] = $this->language->get('button_config');
		$data['button_points'] = $this->language->get('button_points');
		$data['button_io'] = $this->language->get('button_io');

		$data['link_config'] = $this->url->link('shipping/ocstore_pickup', 'token=' . $this->session->data['token'], 'SSL');
		$data['link_points'] = $this->url->link('shipping/ocstore_pickup/points', 'token=' . $this->session->data['token'], 'SSL');
		$data['link_io'] = $this->url->link('shipping/ocstore_pickup/export_import', 'token=' . $this->session->data['token'], 'SSL');

		$data['token'] = $this->session->data['token'];

		$data['breadcrumbs'] = array();

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_home'),
			'href' => $this->url->link('common/dashboard', 'token=' . $this->session->data['token'], 'SSL')
		);

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_shipping'),
			'href' => $this->url->link('extension/shipping', 'token=' . $this->session->data['token'], 'SSL')
		);

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('heading_title'),
			'href' => $this->url->link('module/ocstore_pickup', 'token=' . $this->session->data['token'], 'SSL')
		);


		$data['header'] = $this->load->controller('common/header');
		$data['column_left'] = $this->load->controller('common/column_left');
		$data['footer'] = $this->load->controller('common/footer');

		$this->response->setOutput($this->load->view('ocstore/modules/pickup/export_import.tpl', $data));
	}

}



/*
 * слушай, я начал вчера делать самовывоз, но полного понимания все-таки нет как должно быть в конечном итоге.
Посмотрел сторонние модули и там дофига чего есть и не факт что это надо + у всех все разное.
Собственно у меня такое понимание как это должно быть:
1. список точек, как, например, список товаров с фильтрами по каждому значимому полю: наименование, регион, может еще что-то
2. при добавлении новой точки (изменении старой) добавляются поля
2.1. наименование точки
2.2. регион (есть ли смысл привязываться к разным регионам, если пункт выдачи на стыке двух регионов?)
2.3. адрес точки
2.4. задание точки на карте яндекса или гугла (кстати наверное надо вынести в настройки, чтобы пользователь мог выбирать сервис, наверное для зарубежных это будет гугл, для наших яндекс)
2.5. Стоимость доставки в пункт выдачи
2.6. минимальная сумма заказа для вывода пункта
2.7. флаг вывода пункта выдачи при оформлении заказа, если минимальная сумма не достигнута (типа купите еще на 300р, чтобы можно было бы доставить в пункт выдачи)
2.8. время работы точки
2.9. описание точки (небольшое описание, которое будет выводиться при клике на маркере на карте)
2.10. иконка маркера на карте
2.11. активность точки
2.12. Телефон точки
2.13. email
2.14. ...
3. при оформлении заказа будут выводиться точки списком с возможностью посмотреть подробности точки (все поля из админки) и ссылкой на карту яндекса/гугла с интерактивным просмотром всех точек на карте (при клике на маркер открывается подробности по точке и ссылкой "Выбрать точку" - для ее выбора и закрытия точки)
 */