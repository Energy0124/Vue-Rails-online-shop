import shop from '../../api/shop'
import * as types from '../mutation-types'

// initial state
const state = {
  all: []
}

// getters
const getters = {
  allCategories: state => state.all
}

// actions
const actions = {
  getAllCategories ({ commit }) {
    shop.getCategories(categories => {
      commit(types.RECEIVE_CATEGORIES, { categories })
    })
  }
}

// mutations
const mutations = {
  [types.RECEIVE_CATEGORIES] (state, { categories }) {
    state.all = categories
  }
}

export default {
  state,
  getters,
  actions,
  mutations
}
