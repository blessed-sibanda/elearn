import Vue from 'vue';
import OrderCourses from '../components/OrderCourses.vue';

function renderOrderCourses() {
  const orderCourses = new Vue({
    render: (h) => h(OrderCourses),
  }).$mount();

  document.querySelector('.vue-order-courses').replaceWith(orderCourses.$el);
}

document.addEventListener('turbolinks:load', () => {
  console.log('dom content loaded');
  if (document.querySelector('.vue-order-courses')) {
    renderOrderCourses();
  }
});

document.addEventListener('DOMContentLoaded', () => {
  console.log('dom content loaded');
  if (document.querySelector('.vue-order-courses')) {
    renderOrderCourses();
  }
});
