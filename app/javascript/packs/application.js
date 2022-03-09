// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.
//= require jquery
import Rails from "@rails/ujs";
import Turbolinks from "turbolinks";
import * as ActiveStorage from "@rails/activestorage";
import "channels";

Rails.start();
Turbolinks.start();
ActiveStorage.start();

import "controllers";
import "bootstrap";
import AOS from "aos";
import 'aos/dist/aos.css';
import 'chartkick';
import { initSweetalert } from './init_sweetalert';



// import "chartkick/chart.js";

document.addEventListener("turbolinks:load", () => {
  AOS.init();
  $('[data-toggle="tooltip"]').tooltip()
  initSweetalert('#sweet-alert-demo', {
    title: "A nice alert",
    text: "This is a great alert, isn't it?",
    icon: "success"
  }, () => {
    const link = document.querySelector('#confirm_link');
    link.click();
  });
});

// $(function () {
//   $('[data-toggle="tooltip"]').tooltip()
// })
