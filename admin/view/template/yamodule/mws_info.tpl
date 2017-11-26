<?php echo $header; ?><?php echo $column_left; ?>
<div id="content">
  <div class="page-header">
    <div class="container-fluid">

    </div>
  </div>
  <div class="container-fluid">
    <div class="panel panel-default">
      <div class="panel-heading">
        <h3 class="panel-title"><i class="fa fa-list"></i> <?php echo $heading_title; ?></h3>
      </div>
      <div class="panel-body">
		<?php if(count($mws_order_error)==0){ ?>
        <ul class="nav nav-tabs">
				 <li class="active"><a href="#tab-return" data-toggle="tab"><?php echo $tab_return; ?></a></li>
				 <li><a href="#tab-history" data-toggle="tab"><?php echo $tab_history; ?></a></li>
        </ul>
        <div class="tab-content">
         <div class="tab-pane active" id="tab-return">
			<?php if (isset($return_success)) { ?><p class='alert alert-success'><?php echo $text_return_success; ?></p><?php } ?>
			<?php if (isset($return_error)) foreach ($return_error as $text_err){?><p class='alert alert-danger'><?php echo $text_err; ?></p><?php } ?>
			<form class="form-horizontal" method='post' action='<?php echo $form_return_url; ?>'>
            <table class="table table-bordered">
					<?php if ($invoiceId>0) {?>
				  <tr>
                <td><?php echo $lbl_mws_inv; ?></td>
                <td><?php echo $invoiceId; ?></td>
              </tr>
				  <tr>
                <td><?php echo $text_order_id; ?></td>
                <td><?php echo $order_id; ?></td>
              </tr>
              <tr>
                <td><?php echo $text_payment_method; ?></td>
                <td><?php echo $payment_method; ?></td>
              </tr>
				  <tr>
                <td><?php echo $text_total; ?></td>
                <td><?php echo $order_total; ?></td>
              </tr>
				  <tr>
                <td><?php echo $text_return_total; ?></td>
                <td><?php echo $return_total; ?></td>
              </tr>
					  <tr>
						 <td><?php echo $text_amount; ?></td>
						 <td><input type="text" name="return_sum" class='control-form' value="<?php echo ($return_sum); ?>" id="return_sum" /> руб.</td>
					  </tr>
					  <tr>
						 <td><?php echo $text_cause; ?></td>
						 <td><textarea class='control-form' name='return_cause'></textarea></td>
					  </tr>
					  <tr>
						 <td colspan='2'><button type='submit' class='btn btn-success'><?php echo $btn_return; ?></button></td>
					  </tr>
					<?php } else { ?>
							<tr>
								<td colspan='3'><div class='alert alert-danger'><?php echo $text_invoice_empty; ?> </div></td>
							</tr>
						<?php } ?>
					</table>
				</form>
          </div>
          <div class="tab-pane" id="tab-history">
            <div id="history"></div>
            <br />
            <fieldset>
              <legend><?php echo $text_history; ?></legend>
              <form class="form-horizontal">
                <div class="form-group">
                  <label class="col-sm-2 control-label" for="input-order-status"><?php //echo $entry_order_status; ?></label>
                  <div class="col-sm-10">
						<table class='table'>
							 <tr>
								 <th><?php echo $tbl_head_date; ?></th>
								 <th><?php echo $tbl_head_amount; ?></th>
								 <th><?php echo $tbl_head_cause; ?></th>
							 </tr>
                      <?php if($return_items!==false){
								foreach ($return_items as $key => $item) { ?>
							 <tr>
								 <td><?php echo $item['date']; ?></td>
								 <td><?php echo $item['amount']; ?></td>
								 <td><?php echo $item['cause']; ?></td>
							 </tr>
                      <?php }}else{ ?>
							 <tr>
								 <td colspan='3'><div class='alert alert-danger'><?php echo $text_history_empty; ?> </div></td>
							 </tr>
							 <?php } ?>
						</table>
                  </div>
                </div>
              </form>
            </fieldset>
          </div>
        </div>
		<?php }else{?>
				<?php foreach ($mws_order_error as $alert_text) { ?><div class='alert alert-danger'><?php echo $alert_text; ?> </div> <?php } ?>
		<?php } ?>
      </div>
    </div>
  </div>
</div>
<?php echo $footer; ?> 
