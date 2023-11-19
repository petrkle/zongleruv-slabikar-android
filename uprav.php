<?php

$wget=[];

$log = file_get_contents('log.txt');
$log = preg_replace('/FINISHED.*/s', '', $log);
$log = preg_split('/ saved /', $log);

foreach($log as $foo){
  $foo = trim($foo);
  if(strlen($foo)>0){
    $foo = preg_replace('/\s+/', ' ', $foo);
    $url = preg_replace('/.*http:\/\/localhost:4567([^ ]*) .*/', '$1', $foo);
    $file = preg_replace("#.*app/src/main/assets/www/([^']*)'.*#", '$1', $foo);
    if(preg_match('/^\//', $url)){
      $wget[$url] = $file;
    }
  }
}

$jsfile = glob('app/src/main/assets/www/*.js')[0];

$js = file_get_contents($jsfile);

$js = preg_replace('#/img/s/#', '', $js);

$nahrady = file($jsfile, FILE_IGNORE_NEW_LINES);

foreach($nahrady as $line){
  if(preg_match('/d\.push/', $line)){
    $url = preg_replace('/.*p:"/', '', $line);
    $url = preg_replace('/".*/', '', $url);
    if(isset($wget[$url])){
      $js = preg_replace('#"'.$url.'"#', '"'.$wget[$url].'"', $js);
    }
  }
}

file_put_contents($jsfile, $js);
