<!--
********************************
** TEMPLATE ********************
********************************
-->
<template>
  <div>
    <h1>Users</h1>
    <div class="cards-container">
      <!-- 
        Render UserCard here
      -->
      {{ users }}
    </div>
  </div>
</template>

<!--
********************************
** SCRIPT **********************
********************************
-->
<script>
  import { mapState, mapGetters, mapActions } from "vuex"

  export default {
    name: "users-index",
    data(){
      return {
      }
    },
    computed: Object.assign({},
      mapState({ }),
      mapGetters({ }),
      {
      }
    ),
    methods: Object.assign({},
      mapActions({ }),
      {
      }
    ),
  };
</script>

<!--
********************************
** STYLES **********************
********************************
-->
<style scoped>
  h1 {
    border-bottom: 1px solid grey;
    font-family: 'Arial', sans-serif;
    font-size: 30px;
    font-weight: bold;
    padding: 20px 0;
    text-align: center
  }
  .cards-container {
    box-sizing: border-box;
    margin: 0 auto;
    max-width: 940px;
    padding: 20px;
  }
</style>