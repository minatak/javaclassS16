<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Raleway">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">

<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.min.css">
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://kit.fontawesome.com/df66332deb.js" crossorigin="anonymous"></script>

<!-- 폰트 -->
<link rel="stylesheet" as="style" crossorigin href="https://cdn.jsdelivr.net/gh/orioncactus/pretendard@v1.3.8/dist/web/static/pretendard.css" />
<link href="https://webfontworld.github.io/SCoreDream/SCoreDream.css" rel="stylesheet">
<link href="https://webfontworld.github.io/Cafe24Ssurround/Cafe24Ssurround.css" rel="stylesheet">

<style>
  body, a {
    font-family: 'pretendard';
  }
  h1, h2, h3, h4, h5 {
    font-family: 'pretendard';
  }
  .profile-img {
    width: 60px;
    height: 60px;
    border-radius: 50%;
    background: #ddd;
  }
  .profile-dropdown img {
    border-radius: 50%;
    width: 40px;
    height: 40px;
    object-fit: cover;
  }
  .navbar .container {
    display: flex;
    justify-content: flex-end;
    padding-left: 0;
    padding-right: 0;
  }
  .navbar-brand {
    color: #3a6ea5;
    font-weight: bold;
    margin: 0;
  }
  .serviceCard {
    cursor: pointer;
    text-align: center;
    border: 1px solid #e7e7e7;
    border-radius: 8px;
    padding: 20px;
    transition: transform 0.2s;
  }
  .serviceCard:hover {
    transform: scale(1.05);
  }
  .sidebar {
    width: 280px;
    background-color: #f8f9fa;
    position: fixed;
    top: 0;
    left: 0;
    height: 100%;
    padding-top: 60px;
    border-right: 1px solid #e7e7e7;
  }
  .sidebar a {
    display: block;
    color: black;
    padding: 16px;
    text-decoration: none;
  }
  .sidebar a:hover {
    background-color: #ddd;
  }
  .content {
    margin-left: 300px;
    padding: 20px;
    padding-top: 60px;
    text-align: center;
    max-width: 900px;
    margin: 0 auto;
  }
  .footer {
    background-color: #f8f9fa;
    text-align: center;
    padding: 10px;
    /* position: fixed; */
    left: 0;
    bottom: 0;
    width: 100%;
    border-top: 1px solid #e7e7e7;
  }
  .family-schedule {
    background: #fff;
    padding: 20px;
    border-radius: 15px;
    box-shadow: 0 2px 4px rgba(0,0,0,0.1);
    margin-bottom: 20px;
  }
</style>
