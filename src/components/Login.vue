<template>
  <div class="home">
    <v-breadcrumbs divider="/">
      <v-breadcrumbs-item
        v-for="item in breadcrumbs" :key="item.text"
        :disabled="item.disabled" :to="item.to" :exact=true
      >
        {{ item.text }}
      </v-breadcrumbs-item>
    </v-breadcrumbs>
    <h1>{{ msg }}</h1>

  </div>
</template>

<script>
  export default {
    name: 'login',
    data () {
      return {
        msg: 'Login',
        breadcrumbs: [
          {
            text: 'Login',
            disabled: false,
            to: '/'
          }
        ]
      }
    }
  }
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>

</style>
