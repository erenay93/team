<?php
  include 'php/curl.php';
  include 'php/auth.php';

  $curl = new curl();
  $curl->deneme();

$auth = new auth();
$auth->logout();
  $auth->login("erEn.ay@isik.edu.tr","123");
?>
