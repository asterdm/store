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
                <a href="<?=$link_points;?>" class="btn btn-sm btn-info"><?=$button_points;?></a> |
                <a href="<?=$link_io;?>" class="btn btn-sm btn-success"><?=$button_io;?></a>
                <div class="pull-right">
                    <h5 class="panel-title"><?php echo $ocstore_header; ?></h5>
                </div>
            </div>
            <div class="panel-body">
                <div class="alert alert-danger">
                    <span class="label label-danger">
                       <i class="fa fa-info-circle"></i> <?=$text_error;?>
                    </span>
                    &nbsp;&nbsp;<?=$text_access_denied;?>
                </div>
            </div>
        </div>
    </div>
</div>

<?php echo $footer; ?>