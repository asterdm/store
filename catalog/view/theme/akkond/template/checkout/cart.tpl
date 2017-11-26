<?php echo $header; ?>
<div class="container">
  <ul class="breadcrumb">
    <?php foreach ($breadcrumbs as $breadcrumb) { ?>
    <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
    <?php } ?>
  </ul>
  <?php if ($attention) { ?>
  <div class="alert alert-info"><i class="fa fa-info-circle"></i> <?php echo $attention; ?>
    <button type="button" class="close" data-dismiss="alert">&times;</button>
  </div>
  <?php } ?>
  <?php if ($success) { ?>
  <div class="alert alert-success"><i class="fa fa-check-circle"></i> <?php echo $success; ?>
    <button type="button" class="close" data-dismiss="alert">&times;</button>
  </div>
  <?php } ?>
  <?php if ($error_warning) { ?>
  <div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> <?php echo $error_warning; ?>
    <button type="button" class="close" data-dismiss="alert">&times;</button>
  </div>
  <?php } ?>
  <div class="row"><?php echo $column_left; ?>
    <?php if ($column_left && $column_right) { ?>
    <?php $class = 'col-sm-6'; ?>
    <?php } elseif ($column_left || $column_right) { ?>
    <?php $class = 'col-sm-9'; ?>
    <?php } else { ?>
    <?php $class = 'col-sm-12'; ?>
    <?php } ?>
    <div id="content" class="<?php echo $class; ?>"><?php echo $content_top; ?>
      <h1><?php echo $heading_title; ?>
        <?php if ($weight) { ?>
        &nbsp;(<?php echo $weight; ?>)
        <?php } ?>
      </h1>
      <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data">
        <div class="table-responsive">
          <table class="table table-bordered">
            <thead>
              <tr>
                <td class="text-center"><?php echo $column_image; ?></td>
                <td class="text-left"><?php echo $column_name; ?></td>
                <td class="text-left"><?php echo $column_model; ?></td>
                <td class="text-left"><?php echo $column_quantity; ?></td>
                <td class="text-right"><?php echo $column_price; ?></td>
                <td class="text-right"><?php echo $column_total; ?></td>
              </tr>
            </thead>
            <tbody>
              <?php foreach ($products as $product) { ?>
              <tr>
                <td class="text-center"><?php if ($product['thumb']) { ?>
                  <a href="<?php echo $product['href']; ?>"><img src="<?php echo $product['thumb']; ?>" alt="<?php echo $product['name']; ?>" title="<?php echo $product['name']; ?>" class="img-thumbnail" /></a>
                  <?php } ?></td>
                <td class="text-left"><a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a>
                  <?php if (!$product['stock']) { ?>
                  <span class="text-danger">***</span>
                  <?php } ?>
                  <?php if ($product['option']) { ?>
                  <?php foreach ($product['option'] as $option) { ?>
                  <br />
                  <small><?php echo $option['name']; ?>: <?php echo $option['value']; ?></small>
                  <?php } ?>
                  <?php } ?>
                  <?php if ($product['reward']) { ?>
                  <br />
                  <small><?php echo $product['reward']; ?></small>
                  <?php } ?>
                  <?php if ($product['recurring']) { ?>
                  <br />
                  <span class="label label-info"><?php echo $text_recurring_item; ?></span> <small><?php echo $product['recurring']; ?></small>
                  <?php } ?></td>
                <td class="text-left"><?php echo $product['model']; ?></td>
                <td class="text-left"><div class="input-group btn-block" style="max-width: 200px;">
                    <input type="text" name="quantity[<?php echo $product['cart_id']; ?>]" value="<?php echo $product['quantity']; ?>" size="1" class="form-control" />
                    <span class="input-group-btn">
                    <button type="submit" data-toggle="tooltip" title="<?php echo $button_update; ?>" class="btn btn-primary"><i class="fa fa-refresh"></i></button>
                    <button type="button" data-toggle="tooltip" title="<?php echo $button_remove; ?>" class="btn btn-danger" onclick="cart.remove('<?php echo $product['cart_id']; ?>');"><i class="fa fa-times-circle"></i></button></span></div></td>
                <td class="text-right"><?php echo $product['price']; ?></td>
                <td class="text-right"><?php echo $product['total']; ?></td>
              </tr>
              <?php } ?>
              <?php foreach ($vouchers as $vouchers) { ?>
              <tr>
                <td></td>
                <td class="text-left"><?php echo $vouchers['description']; ?></td>
                <td class="text-left"></td>
                <td class="text-left"><div class="input-group btn-block" style="max-width: 200px;">
                    <input type="text" name="" value="1" size="1" disabled="disabled" class="form-control" />
                    <span class="input-group-btn"><button type="button" data-toggle="tooltip" title="<?php echo $button_remove; ?>" class="btn btn-danger" onclick="voucher.remove('<?php echo $vouchers['key']; ?>');"><i class="fa fa-times-circle"></i></button></span></div></td>
                <td class="text-right"><?php echo $vouchers['amount']; ?></td>
                <td class="text-right"><?php echo $vouchers['amount']; ?></td>
              </tr>
              <?php } ?>
            </tbody>
          </table>
        </div>
      </form>
      <?php if ($coupon || $voucher || $reward || $shipping) { ?>
      <h2><?php echo $text_next; ?></h2>
      <p><?php echo $text_next_choice; ?></p>
      <div class="panel-group" id="accordion"><?php echo $coupon; ?><?php echo $voucher; ?><?php echo $reward; ?><?php echo $shipping; ?></div>
      <?php } ?>
      <br />
      <div class="row">
        <div class="col-sm-offset-8">
          <table class="table table-bordered">
            <?php foreach ($totals as $total) { ?>
            <tr>
              <td class="text-right"><strong><?php echo $total['title']; ?>:</strong></td>
              <td class="text-right"><?php echo $total['text']; ?></td>
            </tr>
            <?php } ?>
          </table>
        </div>
      </div>
      <div class="buttons">
        <div class="pull-left"><a href="<?php echo $continue; ?>" class="btn btn-default"><?php echo $button_shopping; ?></a></div>
        <div class="pull-right"><a href="<?php echo $checkout; ?>" class="btn btn-primary"><?php echo $button_checkout; ?></a></div>
      </div>
      <?php echo $content_bottom; ?>
	  </div>
    <?php echo $column_right; ?>
	</div>


		 <?php if (!$showform): ?>
		 <div class="row">
			<div class="modal-content col-sm-9">
				<!-- StartModalBody -->
				<div class="modal-body"> Форма быстрого заказа

				<!-- FormStart -->
					<form action="<?php echo $qformaction; ?>" method="post" enctype="multipart/form-data" name="sentMessage" id="contactForm" >
					<div class="container-fluid">
						<div class="row">
							<div class="col-md-12">
								<div class="row">


									<!-- StartProductInfo -->
									<div class="col-md-6">
									  <div class="row">
											<!-- StartProductUL -->
										 <table class="table table-bordered">
											<thead>
											  <tr>
												<td class="text-left"><?php echo $column_name; ?></td>
												<td class="text-left"><?php echo $column_quantity; ?></td>
												<td class="text-right"><?php echo $column_total; ?></td>
											  </tr>
											</thead>
											<tbody>
											  <?php foreach ($products as $product) { ?>
											  <tr>

												<td class="text-left"><?php echo $product['name']; ?></td>
												<td class="text-left"><?php echo $product['quantity']; ?></td>
												<td class="text-right"><?php echo $product['total']; ?></td>
											  </tr>
											  <?php } ?>
											</tbody>
										 </table>

											<!-- EndProductUL -->

									  </div>
									  <div class="row">

											<!-- StartProductDesc -->
											<div class="col-md-12 fast-order-desc">
												Внимание! Отправляя заявку в этой форме вы теряете возможность сохранения истории заказов - личного кабинета; применения дополнительных опций и предложений!
											</div>
											<!-- EndProductDesc -->

									  </div>
									</div>
									<!-- EndProductInfo -->

									<!-- StartFiedld -->
									<div class="col-md-6 well">
													 <div class="control-group">
																	<div class="controls">
																	  <div class="input-group">
																	  <span class="input-group-addon"><i class="glyphicon glyphicon-user"></i></span>
																	  <input name="name" type="text" class="form-control" placeholder="Ваше имя" ""="" id="name" required="" data-validation-required-message="Пожалуйста, напишите как к Вам обращаться">
																	  </div>
																	<div class="help-block"></div></div>
															  </div>

															  <div class="control-group">
																	<div class="controls">
																	  <div class="input-group">
																	  <span class="input-group-addon"><i class="glyphicon glyphicon-envelope"></i></span>
																	  <input type="email" name="email"  class="form-control" placeholder="Email" id="email" required="" data-validation-required-message="Пожалуйста, введите свою электронную почту">
																	  </div>
																	<div class="help-block"></div></div>
															  </div>

															  <div class="control-group">
																	<div class="controls">
																	  <div class="input-group">
																	  <span class="input-group-addon"><i class="glyphicon glyphicon-phone"></i></span>
																	  <input type="tel" name="phone" type="phone" pattern="+7 ([0-9]{3}) [0-9]{3}-[0-9]{2}-[0-9]{2}" class="form-control" placeholder="Ваш телефон:" id="phone" required="" data-validation-required-message="Пожалуйста, сообщите свой номер телефона">
																	  </div>
																	<div class="help-block"></div></div>
															  </div>
																<script type="text/javascript">
																				jQuery(function($){
																				   $("#phone").mask("+7 (999) 999-9999");
																				});
																</script>
															  <div class="control-group">
																	<div class="controls">
																	  <textarea name="message" rows="5" cols="100" class="form-control" placeholder="Ваш вопрос:" id="message" maxlength="999" style="resize:none" aria-invalid="false"></textarea>
																	<div class="help-block"></div></div>
															  </div>
									</div>
									<!-- EndField -->

								</div>
							</div>
						</div>
					</div>
																	<!-- StartModalFooter -->
																	<div class="modal-footer">
																	<div id="success"> </div>
                                  <a href="/terms"><input type="checkbox" name="a" checked>Согласен(-а) на обработку персональных данных <a>
																	  <button type="submit" class="btn btn-primary pull-right">Заказать в 1 клик!</button>
																	</div>
																	<!-- EndModalFooter -->
					</form>
					<!-- FormEnd -->

				</div>
				<!-- EndModalBody -->

			</div>
		</div>
		<?php endif; ?>
    <a name="fast-order" ></a>
</div>
<?php echo $footer; ?>