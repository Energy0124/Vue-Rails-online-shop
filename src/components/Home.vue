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
  name: 'home',
  data () {
    return {
      msg: 'Home',
      breadcrumbs: [
        {
          text: 'Home',
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
h1, h2 {
  font-weight: normal;
}

ul {
  list-style-type: none;
  padding: 0;
}

li {
  display: inline-block;
  margin: 0 10px;
}

a {
  color: #42b983;
}
</style>
