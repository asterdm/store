<?php echo $header; ?>
<?php echo $column_left; ?>

<div id="content">
    <div class="page-header">
        <div class="container-fluid">
            <div class="pull-right">
                <button type="submit" form="form" data-toggle="tooltip" title="<?php echo $button_save; ?>" class="btn btn-primary"><i class="fa fa-save"></i></button>
                <a href="<?php echo $cancel; ?>" data-toggle="tooltip" title="<?php echo $button_cancel; ?>" class="btn btn-default"><i class="fa fa-reply"></i></a>
            </div>

            <h1><?php echo $heading_title; ?></h1>

            <ul class="breadcrumb">
                <?php foreach ($breadcrumbs as $breadcrumb) { ?>
                <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
                <?php } ?>
            </ul>
        </div>
    </div>

    <div class="container-fluid">
        <?php if (isset($error_warning)) { ?>
        <div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> <?php echo $error_warning; ?>
            <button type="button" class="close" data-dismiss="alert">&times;</button>
        </div>
        <?php } ?>

        <div class="panel panel-default">
            <div class="panel-body">
                <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form" class="form-horizontal">

                    <div class="tab-content">
                        <div class="tab-pane active" id="tab-general">
                            <div class="form-group  required">
                                <label class="col-sm-2 control-label" for="tinkoff_terminal_key"><?php echo $terminal_key_label; ?></label>

                                <div class="col-sm-10">
                                    <input type="text" name="tinkoff_terminal_key" value="<?php echo $tinkoff_terminal_key; ?>" class="form-control"/>
                                    <?php if (isset($error['terminal_key'])) { ?>
                                    <span class="error"><?php echo $error['terminal_key']; ?></span>
                                    <?php } ?>
                                </div>
                            </div>
                            <div class="form-group  required">
                                <label class="col-sm-2 control-label" for="tinkoff_secret_key"><?php echo $secret_key_label; ?></label>

                                <div class="col-sm-10">
                                    <input type="text" name="tinkoff_secret_key" value="<?php echo $tinkoff_secret_key; ?>" class="form-control"/>
                                    <?php if (isset($error['tinkoff_secret_key'])) { ?>
                                    <span class="error"><?php echo $error['tinkoff_secret_key']; ?></span>
                                    <?php } ?>
                                </div>
                            </div>
                            <div class="form-group  required">
                                <label class="col-sm-2 control-label" for="tinkoff_payment_url"><?php echo $payment_url_label; ?></label>

                                <div class="col-sm-10">
                                    <input type="text" name="tinkoff_payment_url" value="<?php echo $tinkoff_payment_url; ?>" class="form-control"/>
                                    <?php if (isset($error['payment_url'])) { ?>
                                    <span class="error"><?php echo $error['payment_url']; ?></span>
                                    <?php } ?>
                                </div>
                            </div>
                            <!-- order statuses -->
                            <div class="form-group">
                                <label class="col-sm-2 control-label" for="tinkoff_order_status_authorized"><?php echo $status_authorized; ?></label>
                                <div class="col-sm-10">
                                    <select name="tinkoff_order_status_authorized" id="tinkoff_order_status_authorized" class="form-control">
                                        <?php foreach ($order_statuses as $order_status) { ?>
                                        <?php if ($order_status['order_status_id'] == $tinkoff_order_status_authorized) { ?>
                                        <option value="<?php echo $order_status['order_status_id']; ?>" selected="selected"><?php echo $order_status['name']; ?></option>
                                        <?php } else { ?>
                                        <option value="<?php echo $order_status['order_status_id']; ?>"><?php echo $order_status['name']; ?></option>
                                        <?php } ?>
                                        <?php } ?>
                                    </select>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 control-label" for="tinkoff_order_status_completed"><?php echo $status_completed; ?></label>
                                <div class="col-sm-10">
                                    <select name="tinkoff_order_status_completed" id="tinkoff_order_status_completed" class="form-control">
                                        <?php foreach ($order_statuses as $order_status) { ?>
                                        <?php if ($order_status['order_status_id'] == $tinkoff_order_status_completed) { ?>
                                        <option value="<?php echo $order_status['order_status_id']; ?>" selected="selected"><?php echo $order_status['name']; ?></option>
                                        <?php } else { ?>
                                        <option value="<?php echo $order_status['order_status_id']; ?>"><?php echo $order_status['name']; ?></option>
                                        <?php } ?>
                                        <?php } ?>
                                    </select>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 control-label" for="tinkoff_order_status_canceled"><?php echo $status_canceled; ?></label>
                                <div class="col-sm-10">
                                    <select name="tinkoff_order_status_canceled" id="tinkoff_order_status_canceled" class="form-control">
                                        <?php foreach ($order_statuses as $order_status) { ?>
                                        <?php if ($order_status['order_status_id'] == $tinkoff_order_status_canceled) { ?>
                                        <option value="<?php echo $order_status['order_status_id']; ?>" selected="selected"><?php echo $order_status['name']; ?></option>
                                        <?php } else { ?>
                                        <option value="<?php echo $order_status['order_status_id']; ?>"><?php echo $order_status['name']; ?></option>
                                        <?php } ?>
                                        <?php } ?>
                                    </select>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 control-label" for="tinkoff_order_status_rejected"><?php echo $status_rejected; ?></label>
                                <div class="col-sm-10">
                                    <select name="tinkoff_order_status_rejected" id="tinkoff_order_status_rejected" class="form-control">
                                        <?php foreach ($order_statuses as $order_status) { ?>
                                        <?php if ($order_status['order_status_id'] == $tinkoff_order_status_rejected) { ?>
                                        <option value="<?php echo $order_status['order_status_id']; ?>" selected="selected"><?php echo $order_status['name']; ?></option>
                                        <?php } else { ?>
                                        <option value="<?php echo $order_status['order_status_id']; ?>"><?php echo $order_status['name']; ?></option>
                                        <?php } ?>
                                        <?php } ?>
                                    </select>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 control-label" for="tinkoff_order_status_refunded"><?php echo $status_refunded; ?></label>
                                <div class="col-sm-10">
                                    <select name="tinkoff_order_status_refunded" id="tinkoff_order_status_refunded" class="form-control">
                                        <?php foreach ($order_statuses as $order_status) { ?>
                                        <?php if ($order_status['order_status_id'] == $tinkoff_order_status_refunded) { ?>
                                        <option value="<?php echo $order_status['order_status_id']; ?>" selected="selected"><?php echo $order_status['name']; ?></option>
                                        <?php } else { ?>
                                        <option value="<?php echo $order_status['order_status_id']; ?>"><?php echo $order_status['name']; ?></option>
                                        <?php } ?>
                                        <?php } ?>
                                    </select>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-sm-2 control-label" for="tinkoff_sort_order"><?php echo $sort_order; ?></label>
                                <div class="col-sm-10">
                                    <input type="text" name="tinkoff_sort_order" value="<?php echo $tinkoff_sort_order; ?>" class="form-control"/>
                                </div>
                            </div>
                            
                            <div class="form-group">
                                <label class="col-sm-2 control-label" for="tinkoff_status"><?php echo $status_label; ?></label>

                                <div class="col-sm-10">
                                    <select name="tinkoff_status" class="form-control">
                                        <?php if ($tinkoff_status) { ?>
                                        <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                                        <option value="0"><?php echo $text_disabled; ?></option>
                                        <?php } else { ?>
                                        <option value="1"><?php echo $text_enabled; ?></option>
                                        <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                                        <?php } ?>
                                    </select>
                                </div>
                            </div>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<?php echo $footer; ?>