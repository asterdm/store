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
                <a href="<?=$link_config;?>" class="btn btn-sm btn-success"><?=$button_config;?></a> |
                <a href="<?=$link_points;?>" class="btn btn-sm btn-info"><?=$button_points;?></a> |
                <a href="<?=$link_io;?>" class="btn btn-sm btn-info"><?=$button_io;?></a>
                <div class="pull-right">
                    <h5 class="panel-title"><?php echo $ocstore_header; ?></h5>
                </div>
            </div>
            <div class="panel-body">
                <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" class="form-horizontal">
                    <div class="form-group">
                        <label class="col-sm-3 control-label" for="ocstore_pickup_status"><?=$entry_points_enable;?></label>
                        <div class="col-sm-9">
                            <select class="form-control" name="ocstore_pickup_status">
                                <option value="0" <?=($ocstore_pickup_status == 0? "SELECTED": "");?>><?=$entry_disabled;?>
                                <option value="1" <?=($ocstore_pickup_status == 1? "SELECTED": "");?>><?=$entry_enabled;?>
                            </select>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="col-sm-3 control-label" for="ocstore_pickup_country"><?=$entry_country;?></label>
                        <div class="col-sm-9">
                            <select class="form-control" name="ocstore_pickup_country">
                                <? foreach ($countries as $country): ?>
                                    <option value="<?=$country['country_id'];?>" <?=($country['country_id'] == $ocstore_pickup_country? "SELECTED": "");?>><?=$country['name'];?>
                                <? endforeach; ?>
                            </select>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="col-sm-3 control-label" for="ocstore_pickup_maptype"><?=$entry_map_type;?></label>
                        <div class="col-sm-9">
                            <select class="form-control" name="ocstore_pickup_maptype">
                                <? foreach ($ocstore_pickup_maptypes as $type => $nameType): ?>
                                    <option value="<?=$type;?>" <?=($type == $ocstore_pickup_maptype? "SELECTED": "");?>><?=$nameType;?>
                                <? endforeach; ?>
                            </select>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="col-sm-3 control-label" for="ocstore_pickup_image"><?php echo $entry_map_icon; ?></label>
                        <div class="col-sm-9">
                            <a href="" id="thumb-image" data-toggle="image" class="img-thumbnail"><img src="<?=$ocstore_pickup_image; ?>" alt="" title=""  /></a>
                            <input type="hidden" name="ocstore_pickup_image" value="<?=$ocstore_pickup_image;?>" id="input-image" />
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

<?php echo $footer; ?>