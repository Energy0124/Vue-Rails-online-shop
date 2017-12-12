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
    <social-sharing url="https://s11.ierg4210.ie.cuhk.edu.hk/"
                    title="The Most Buggy Vue.js shop ever"
                    description="Intuitive, Fast and Composable Shop"
                    quote="ACGN is the bset~"
                    hashtags="vuejs,shop"
                    twitter-user="energy0124"
                    inline-template>
      <div>
        <network network="email">
          <v-icon>email</v-icon>
          Email
        </network>
        <network network="facebook">
          <v-icon> facebook</v-icon>Facebook
        </network>
        <network network="googleplus">
           Google +
        </network>
        <network network="reddit">
          Reddit
        </network>

      </div>
    </social-sharing>

  </div>
</template>

<script>
  import SocialSharing from 'vue-social-sharing'
  export default {
    components: [
      SocialSharing
    ],
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
