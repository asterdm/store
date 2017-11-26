<div class="panel panel-default">
  <div class="panel-heading"><?php echo $heading_title; ?></div>
  <div class="panel-body">
  <?php foreach ($all_news as $news) { ?>
	<div class="news">
	  <a class="news-heading" href="<?php echo $news['view']; ?>"><?php echo $news['title']; ?></a>
	  
	  <span class="news-heading-title" style="float:right;"><?php echo $news['date_added']; ?></span><br />
	  <span class="news-description"><?php echo $news['description']; ?></span>
	</div>
  <?php } ?>
  </div>
</div>