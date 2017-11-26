<?php echo $header; ?><?php echo $column_left; ?>
<div id="content">
    <div class="page-header">
        <div class="container-fluid">
            <div class="pull-right">
                <a href="<?php echo $cancel; ?>" data-toggle="tooltip" title="<?php echo $button_cancel; ?>"
                   class="btn btn-default"><i class="fa fa-reply"></i></a></div>
            <h1><?php echo $heading_title; ?></h1>
            <ul class="breadcrumb">
                <?php foreach ($breadcrumbs as $breadcrumb) { ?>
                <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
                <?php } ?>
            </ul>
        </div>
    </div>
    <div class="container-fluid">
        <div class="panel panel-default">
            <div class="panel-heading">
                <a href="<?=$link_config;?>" class="btn btn-sm btn-info"><?=$button_config;?></a> |
                <a href="<?=$link_points;?>" class="btn btn-sm btn-success"><?=$button_points;?></a> |
                <a href="<?=$link_io;?>" class="btn btn-sm btn-info"><?=$button_io;?></a>
                <div class="pull-right">
                    <h5 class="panel-title"><?php echo $ocstore_header; ?></h5>
                </div>
            </div>
            <div class="panel-body">
                <? if(isset($error)): ?>
                    <div class="alert alert-danger">
                        <?=$error;?>
                    </div>
                <? endif; ?>
                <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" class="form-horizontal">
                    <div class="form-group required <?=(isset($errors['ocstore_pickup_name'])? "has-error": "");?>">
                        <label class="col-sm-3 control-label" for="ocstore_pickup_name"><?=$entry_points_name;?></label>
                        <div class="col-sm-9">
                            <input type="text" name="ocstore_pickup_name" value="<?=$ocstore_pickup_name;?>" class="form-control"  />
                            <? if(isset($errors['ocstore_pickup_name'])): ?>
                                <div class="alert alert-danger" style="margin-top: 5px">
                                    <?=$errors['ocstore_pickup_name'];?>
                                </div>
                            <? endif; ?>
                        </div>
                    </div>
                    <div class="form-group required <?=(isset($errors['ocstore_pickup_address'])? "has-error": "");?>">
                        <label class="col-sm-3 control-label" for="ocstore_pickup_address"><?=$entry_points_address;?></label>
                        <div class="col-sm-9">
                            <input type="text" name="ocstore_pickup_address" value="<?=$ocstore_pickup_address;?>" class="form-control"  />
                            <? if(isset($errors['ocstore_pickup_address'])): ?>
                                <div class="alert alert-danger" style="margin-top: 5px">
                                    <?=$errors['ocstore_pickup_address'];?>
                                </div>
                            <? endif; ?>
                        </div>
                    </div>
                    <div class="form-group required <?=(isset($errors['ocstore_pickup_worktime'])? "has-error": "");?>">
                        <label class="col-sm-3 control-label" for="ocstore_pickup_worktime"><?=$entry_points_worktime;?></label>
                        <div class="col-sm-9">
                            <input type="text" name="ocstore_pickup_worktime" value="<?=$ocstore_pickup_worktime;?>" class="form-control"  />
                            <? if(isset($errors['ocstore_pickup_worktime'])): ?>
                                <div class="alert alert-danger" style="margin-top: 5px">
                                    <?=$errors['ocstore_pickup_worktime'];?>
                                </div>
                            <? endif; ?>
                        </div>
                    </div>
                    <div class="form-group required <?=(isset($errors['ocstore_pickup_phone'])? "has-error": "");?>">
                        <label class="col-sm-3 control-label" for="ocstore_pickup_phone"><?=$entry_points_phone;?></label>
                        <div class="col-sm-9">
                            <input type="text" name="ocstore_pickup_phone" value="<?=$ocstore_pickup_phone;?>" class="form-control"  />
                            <? if(isset($errors['ocstore_pickup_phone'])): ?>
                                <div class="alert alert-danger" style="margin-top: 5px">
                                    <?=$errors['ocstore_pickup_phone'];?>
                                </div>
                            <? endif; ?>
                        </div>
                    </div>
                    <div class="form-group <?=(isset($errors['ocstore_pickup_email'])? "has-error": "");?>">
                        <label class="col-sm-3 control-label" for="ocstore_pickup_email"><?=$entry_points_email;?></label>
                        <div class="col-sm-9">
                            <input type="text" name="ocstore_pickup_email" value="<?=$ocstore_pickup_email;?>" class="form-control"  />
                            <? if(isset($errors['ocstore_pickup_email'])): ?>
                                <div class="alert alert-danger" style="margin-top: 5px">
                                    <?=$errors['ocstore_pickup_email'];?>
                                </div>
                            <? endif; ?>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-3 control-label" for="ocstore_pickup_description"><?=$entry_points_description;?></label>
                        <div class="col-sm-9">
                            <textarea name="ocstore_pickup_description" id="ocstore_pickup_description"><?=$ocstore_pickup_description;?></textarea>
                        </div>
                    </div>
                    <div class="form-group required <?=(isset($errors['ocstore_pickup_zone_id'])? "has-error": "");?>">
                        <label class="col-sm-3 control-label" for="ocstore_pickup_zone_id"><?=$entry_points_zone;?></label>
                        <div class="col-sm-9">
                            <select name="ocstore_pickup_zone_id" class="form-control">
                                <? foreach ($ocstore_pickup_zones as $zone): ?>
                                    <option value="<?=$zone['zone_id'];?>" <?=($zone['zone_id'] == $ocstore_pickup_zone_id? "SELECTED": "");?>><?=$zone['name'];?></option>
                                <? endforeach; ?>
                            </select>
                            <? if(isset($errors['ocstore_pickup_zone_id'])): ?>
                                <div class="alert alert-danger" style="margin-top: 5px">
                                    <?=$errors['ocstore_pickup_zone_id'];?>
                                </div>
                            <? endif; ?>
                        </div>
                    </div>
                    <div class="form-group required <?=(isset($errors['ocstore_pickup_cost_delivery'])? "has-error": "");?>">
                        <label class="col-sm-3 control-label" for="ocstore_pickup_cost_delivery"><?=$entry_points_cost_delivery;?></label>
                        <div class="col-sm-9">
                            <input type="text" name="ocstore_pickup_cost_delivery" value="<?=$ocstore_pickup_cost_delivery;?>" class="form-control"  />
                            <? if(isset($errors['ocstore_pickup_cost_delivery'])): ?>
                                <div class="alert alert-danger" style="margin-top: 5px">
                                    <?=$errors['ocstore_pickup_cost_delivery'];?>
                                </div>
                            <? endif; ?>
                        </div>
                    </div>
                    <div class="form-group required <?=(isset($errors['ocstore_pickup_enable'])? "has-error": "");?>">
                        <label class="col-sm-3 control-label" for="ocstore_pickup_enable"><?=$entry_points_enable;?></label>
                        <div class="col-sm-9">
                            <select name="ocstore_pickup_enable" class="form-control">
                                <option value="0" <?=($ocstore_pickup_enable == 0? "SELECTED": "");?>><?=$entry_points_enable_disable;?></option>
                                <option value="1" <?=($ocstore_pickup_enable == 1? "SELECTED": "");?>><?=$entry_points_enable_enable;?></option>
                            </select>
                            <? if(isset($errors['ocstore_pickup_enable'])): ?>
                                <div class="alert alert-danger" style="margin-top: 5px">
                                    <?=$errors['ocstore_pickup_enable'];?>
                                </div>
                            <? endif; ?>
                        </div>
                    </div>



                    <div class="form-group">
                        <div class="col-sm-9 col-sm-offset-3">
                            <button type="submit" data-toggle="tooltip" title="<?php echo $button_save; ?>" class="btn btn-success"><i class="fa fa-save"></i>&nbsp;&nbsp;<?php echo $button_save; ?></button>
                        </div>
                    </div>
                </form>

            </div>
        </div>
    </div>
</div>

<script type="text/javascript"><!--
    $('#ocstore_pickup_description').summernote({height: 200});
//--></script>

<?php echo $footer; ?>