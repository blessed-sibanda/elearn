<template>
  <div id="order-courses" class="level-right">
    <div class="level-item">
      Order by
    </div>
    <div class="level-item">
      <div class="select">
        <select @change="filterCourses" v-model="field">
          <option value="created_at">Date</option>
          <option value="price">Price</option>
        </select>
      </div>
    </div>
    <div class="level-item">
      <div class="select">
        <select @change="filterCourses" v-model="order">
          <option value="asc">Asc</option>
          <option value="desc">Desc</option>
        </select>
      </div>
    </div>
  </div>
</template>

<script>
import axios from 'axios';
export default {
  data() {
    return {
      field: 'created_at',
      order: 'desc',
    };
  },
  methods: {
    async filterCourses() {
      try {
        let baseUrl = window.location.href;
        if (baseUrl.includes('?')) {
          baseUrl = baseUrl + '&';
        } else {
          baseUrl = baseUrl + '?';
        }
        let url = `${baseUrl}field=${this.field}&order=${this.order}`;
        const response = await axios.get(url, {
          headers: { 'X-Requested-With': 'XMLHttpRequest' },
        });

        let courses = document.getElementById('courses');
        courses.innerHTML = response.data;
      } catch (error) {
        console.error(error);
      }
    },
  },
};
</script>

<style></style>
