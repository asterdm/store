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
				<? if (isset($error)) : ?>
					<div class="alert alert-danger"><?=$error;?></div>
				<? endif;?>
				<? if (isset($success)) : ?>
					<div class="alert alert-success"><?=$success;?></div>
				<? endif;?>
                <form method="post">
                    <table class="table table-striped">
                        <thead>
                            <tr>
                                <th><?=$entry_points_name;?></th>
                                <th><?=$entry_points_zone;?></th>
                                <th><?=$entry_points_address;?></th>
                                <th><?=$entry_points_worktime;?></th>
                                <th><?=$entry_points_enable;?></th>
                                <th width="60"></th>
                            </tr>
                            <tr>
                                <th><input type="text" class="form-control input-sm" name="filter[ocstore_pickup_name]" value="<?=(isset($filter['ocstore_pickup_name'])? $filter['ocstore_pickup_name']: "");?>" placeholder="<?=$entry_points_name;?>" /></th>
                                <th><input type="text" class="form-control input-sm" name="filter[ocstore_pickup_zone]" value="<?=(isset($filter['ocstore_pickup_zone'])? $filter['ocstore_pickup_zone']: "");?>" placeholder="<?=$entry_points_zone;?>" /></th>
                                <th><input type="text" class="form-control input-sm" name="filter[ocstore_pickup_address]" value="<?=(isset($filter['ocstore_pickup_address'])? $filter['ocstore_pickup_address']: "");?>" placeholder="<?=$entry_points_address;?>" /></th>
                                <th><input type="text" class="form-control input-sm" name="filter[ocstore_pickup_worktime]" value="<?=(isset($filter['ocstore_pickup_worktime'])? $filter['ocstore_pickup_worktime']: "");?>" placeholder="<?=$entry_points_worktime;?>" /></th>
                                <th>
                                    <select class="form-control input-sm" name="filter[ocstore_pickup_enable]">
                                        <option value="-1"><?=$entry_active_unknown;?></option>
                                        <option value="1" <?=(isset($filter['ocstore_pickup_enable']) && $filter['ocstore_pickup_enable'] == 1? "SELECTED": "");?>><?=$entry_enabled;?></option>
                                        <option value="0" <?=(isset($filter['ocstore_pickup_enable']) && $filter['ocstore_pickup_enable'] == 0? "SELECTED": "");?>><?=$entry_disabled;?></option>
                                    </select>
                                </th>
                                <th width="100"><input type="submit" value="<?=$button_apply;?>" class="btn btn-info btn-block btn-sm" /></th>
                            </tr>
                        </thead>
                        <tbody>
                            <? foreach ($points as $p): ?>
                                <tr <?=($p['enable']==0? 'class="danger"': "");?>>
                                    <td><?=$p['name'];?></td>
                                    <td><?=$p['zone_name'];?></td>
                                    <td><?=$p['address'];?></td>
                                    <td><?=$p['worktime'];?></td>
                                    <td><?=($p['enable'] == 1? $entry_enabled: $entry_disabled);?></td>
                                    <td class="text-right">
                                        <a href="<?=$link_edit;?>&pickup_id=<?=$p['ocstore_pickup_id'];?>" data-toggle="tooltip" title="" class="btn btn-xs btn-primary" data-original-title="<?=$button_edit;?>"><i class="fa fa-pencil"></i></a>
                                        <a href="<?=$link_remove;?>&pickup_id=<?=$p['ocstore_pickup_id'];?>" data-toggle="tooltip" title="" class="btn btn-xs btn-danger" data-original-title="<?=$button_remove;?>"><i class="fa fa-times"></i></a>
                                    </td>
                                </tr>
                            <? endforeach; ?>
                        </tbody>
                    </table>
                </form>
                <a href="<?=$link_add;?>" class="btn btn-sm btn-success"><?=$button_add;?></a>
            </div>
        </div>
    </div>
</div>

<?php echo $footer; ?>