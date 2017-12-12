<template>
  <v-tabs dark fixed centered>
    <v-tabs-bar class="cyan">
      <v-tabs-slider class="yellow"></v-tabs-slider>
      <v-tabs-item
        v-for="i in items"
        :key="i"
        :href="'#tab-' + i"
      >
        {{ i }}
      </v-tabs-item>
    </v-tabs-bar>
    <v-tabs-items>
      <v-tabs-content
        :id="'tab-' + 'Products'"
      >
        <v-card>
          <v-form :v-model="validProduct" ref="productForm">
            <v-text-field
              disabled
              label="Id"
              v-model="product.id"
            ></v-text-field>
            <v-text-field
              label="Name"
              v-model="product.name"
              required
            ></v-text-field>
            <v-text-field
              label="Price"
              v-model="product.price"
              required
            ></v-text-field>
            <v-text-field
              label="Description"
              v-model="product.description"
            ></v-text-field>
            <v-text-field
              label="Image Url"
              v-model="product.image_url"
            ></v-text-field>

            <vue-base64-file-upload
              v-if="showImageUpload"
              class="v1"
              accept='image/png,image/gif,image/jpeg'
              image-class="v1-image"
              input-class="v1-input"
              :max-size="customImageMaxSize"
              @size-exceeded="onSizeExceeded"
              @file="onFile"
              @load="onLoad">
            </vue-base64-file-upload>
            <v-text-field
              label="Category"
              v-model="product.category_id"
              required
            ></v-text-field>
            <v-btn
              @click="submitProduct"
              :disabled="!validProduct"
            >
              {{btnProductText}}
            </v-btn>
            <v-btn @click="clearProduct">clear</v-btn>
          </v-form>
        </v-card>
        <v-list>
          <v-list-tile avatar v-for="product in products" v-bind:key="product.id"
                       @click.stop="selectProduct(product.id)">
            <v-list-tile-avatar>
              <!--<img v-bind:src="$config.IMAGE_ROOT+ product.image_url"/>-->
              <img v-bind:src="product.image_url"/>
            </v-list-tile-avatar>
            <v-list-tile-content>
              <v-list-tile-title v-text="product.name"></v-list-tile-title>
              <v-list-tile-sub-title>{{ product.id }}</v-list-tile-sub-title>
            </v-list-tile-content>
            <v-list-tile-action>
              <v-btn icon ripple @click.stop="deleteProduct(product.id)">
                <v-icon color="pink">delete</v-icon>
              </v-btn>
            </v-list-tile-action>
          </v-list-tile>
        </v-list>
      </v-tabs-content>
      <v-tabs-content
        :id="'tab-' + 'Categories'"
      >
        <v-card>
          <v-form :v-model="validCategory" ref="categoryForm">
            <v-text-field
              disabled
              label="Id"
              v-model="category.id"
            ></v-text-field>
            <v-text-field
              label="Name"
              v-model="category.name"
              required
            ></v-text-field>
            <v-btn
              @click="submitCategory"
              :disabled="!validCategory"
            >
              {{btnCategoryText}}
            </v-btn>
            <v-btn @click="clearCategory">clear</v-btn>
          </v-form>
        </v-card>
        <v-list>
          <v-list-tile avatar v-for="category in categories" v-bind:key="category.id"
                       @click="selectCategory(category.id)">
            <v-list-tile-content>
              <v-list-tile-title v-text="category.name"></v-list-tile-title>
              <v-list-tile-sub-title>{{ category.id }}</v-list-tile-sub-title>
            </v-list-tile-content>
            <v-list-tile-action>
              <v-btn icon ripple @click.stop="deleteCategory(category.id)">
                <v-icon color="pink">delete</v-icon>
              </v-btn>
            </v-list-tile-action>
          </v-list-tile>
        </v-list>
      </v-tabs-content>
      <v-tabs-content
        :id="'tab-' + 'Orders'"
      >
        <v-list>
          <v-list-tile avatar v-for="order in orders" v-bind:key="order.id">
            <v-list-tile-content>
              <v-list-tile-title v-text="order.payment_id"></v-list-tile-title>
              <v-list-tile-sub-title>{{ '$' + order.total_price }}</v-list-tile-sub-title>
            </v-list-tile-content>
          </v-list-tile>
        </v-list>
      </v-tabs-content>
    </v-tabs-items>
  </v-tabs>
</template>

<script>
  import VueBase64FileUpload from 'vue-base64-file-upload'
  import Vue from 'vue'
  import { mapGetters } from 'vuex'
  export default {
    components: {
      VueBase64FileUpload,
      Vue
    },
    computed: {
      btnProductText: function () {
        return this.updateProduct ? 'Save changes' : ' Create new'
      },
      btnCategoryText: function () {
        return this.updateCategory ? 'Save changes' : ' Create new'
      },
      ...mapGetters({
        products: 'allProducts',
        categories: 'allCategories',
        user: 'user'
      })
    },
    data () {
      return {
        showImageUpload: true,
        customImageMaxSize: 10,
        validProduct: true,
        validCategory: true,
        items: ['Products', 'Categories', 'Orders'],
        product: {},
        category: {},
        updateProduct: false,
        updateCategory: false,
        orders: []
      }
    },
    created () {
      if (this.user.roles !== 'admin') {
        this.$router.push({path: '/home'})
      }
      this.$store.dispatch('getAllProducts')
      this.$store.dispatch('getAllCategories')
    },
    mounted () {
      this.$http.get('orders', {
        headers: {
          Authorization: this.user.auth_token
        }
      })
        .then((response) => {
          console.log(response)
          this.orders = response.body
        })
    },
    methods: {
      onFile (file) {
        console.log(file) // file object
      },

      onLoad (dataUri) {
        this.product.picture = dataUri
      },

      onSizeExceeded (size) {
        alert(`Image ${size}Mb size exceeds limits of ${this.customImageMaxSize}Mb!`)
      },
      selectProduct (id) {
        this.product = Object.assign({}, this.product, this.products.find(p => p.id === id))
        this.updateProduct = true
      },
      selectCategory (id) {
        this.category = Object.assign({}, this.category, this.categories.find(p => p.id === id))
        this.updateCategory = true
      },
      deleteProduct (id) {
        this.$http.delete('products/' + id, {
          headers: {
            Authorization: this.user.auth_token
          }
        })
          .then((response) => {
            console.log(response)
            this.$store.dispatch('getAllProducts')
          })
      },
      deleteCategory (id) {
        this.$http.delete('categories/' + id, {
          headers: {
            Authorization: this.user.auth_token
          }
        })
          .then((response) => {
            console.log(response)
            this.$store.dispatch('getAllCategories')
          })
      },
      submitProduct () {
        if (this.$refs.productForm.validate()) {
          // Native form submission is not yet supported
          if (this.updateProduct) {
            this.$http.patch('products/' + this.product.id, this.product, {
              headers: {
                Authorization: this.user.auth_token
              }
            }).then((response) => {
              console.log(response)
              this.$store.dispatch('getAllProducts')
              this.updateProduct = false
              this.clearProduct()
            })
          } else {
            this.$http.post('products', this.product, {
              headers: {
                Authorization: this.user.auth_token
              }
            }).then((response) => {
              console.log(response)
              this.$store.dispatch('getAllProducts')
              this.updateProduct = false
              this.clearProduct()
            })
          }
        }
      },
      submitCategory () {
        if (this.$refs.categoryForm.validate()) {
          // Native form submission is not yet supported
          if (this.updateCategory) {
            this.$http.patch('categories/' + this.category.id, this.category, {
              headers: {
                Authorization: this.user.auth_token
              }
            }).then((response) => {
              console.log(response)
              this.$store.dispatch('getAllCategories')
              this.updateCategory = false
              this.clearCategory()
            })
          } else {
            this.$http.post('categories', this.category, {
              headers: {
                Authorization: this.user.auth_token
              }
            })
              .then((response) => {
                console.log(response)
                this.$store.dispatch('getAllCategories')
                this.updateCategory = false
                this.clearCategory()
              })
          }
        }
      },
      clearProduct () {
        this.$refs.productForm.reset()
        this.product = {}
        this.updateProduct = false
        this.showImageUpload = false
        setTimeout(function () { this.showImageUpload = true }.bind(this), 100)
      },
      clearCategory () {
        this.$refs.categoryForm.reset()
        this.category = {}
        this.updateCategory = false
      }
    }
  }
</script>

