<template>
  <v-container fluid grid-list-xl>
    <v-layout row justify-center>
      <v-flex xs6>
        <v-card>
          <v-card-media src="/static/miku_welcome_sign__free_to_use__by_pinkbunnii-d5s9380.gif" height="300px">
          </v-card-media>
          <v-card-title primary-title>
            <div>
              <h3 class="headline mb-0">Login</h3>
            </div>
          </v-card-title>
          <form>
            <v-text-field
              v-model="email"
              label="E-mail"
              :error-messages="errors.collect('email')"
              v-validate="'required|email'"
              data-vv-name="email"
              required
            ></v-text-field>
            <v-text-field
              label="Password"
              hint="At least 8 characters"
              v-model="password"
              data-vv-name="password"
              v-validate="'required|min:8'"
              :error-messages="errors.collect('password')"
              :append-icon="hidePassword ? 'visibility' : 'visibility_off'"
              :append-icon-cb="togglePassword"
              :type="hidePassword ? 'password' : 'text'"
              counter
              required
            ></v-text-field>

            <v-btn @click="submit">submit</v-btn>
            <v-btn @click="clear">clear</v-btn>
          </form>
          <v-alert v-if="loginFailed" error icon="warning" value="true" dismissible v-model="loginFailed">
            Your entered email or password is incorrect. Please retry.
          </v-alert>
        </v-card>

      </v-flex>
    </v-layout>
  </v-container>

</template>

<script>
  export default {
    $validates: true,
    data () {
      return {
        localStorage: {
          auth_token: {
            type: String,
            default: ''
          }
        },
        hidePassword: true,
        email: '',
        password: '',
        loginFailed: false
      }
    },
    created () {
      let token = this.$localStorage.get('auth_token')

      if (token !== '') {
        this.$http.post('users/info', {}, {
          headers: {
            Authorization: token
          }
        }).then((response) => {
          let user = {}
          user = response.body
          this.$store.dispatch('updateUser', user)
          this.$localStorage.set('auth_token', user.auth_token)
          if (user.roles === 'admin') {
            this.$router.push({path: '/admin'})
          } else {
            this.$router.push({path: '/home'})
          }
        })
      }
    },
    methods: {
      submit () {
        this.$validator.validateAll().then((result) => {
          if (result) {
            let user = {
              user: {
                email: this.email,
                password: this.password
              }
            }
            this.$http.post('users/login', user)
              .then((response) => {
//                console.log(response)
                user = response.body
                this.$store.dispatch('updateUser', user)
                this.$localStorage.set('auth_token', user.auth_token)
                if (user.roles === 'admin') {
                  this.$router.push({path: '/admin'})
                } else {
                  this.$router.push({path: '/home'})
                }
              }, response => {
                this.loginFailed = true
              })
          }
        })
      },
      clear () {
        this.email = ''
        this.password = ''
        this.loginFailed = false
        this.$validator.clean()
      },
      togglePassword () {
        this.hidePassword = !this.hidePassword
      }
    }

  }
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>

</style>
