import * as types from '../mutation-types'

// initial state
const state = {
  user: {
    email: null,
    auth_token: null,
    roles: null
  }
}

// getters
const getters = {
  user: state => state.user
}

// actions
const actions = {
  updateUser ({ commit }, user) {
    commit(types.UPDATE_USER, { user })
  },
  logout ({ commit }) {
    let user = {
      email: null,
      auth_token: null,
      roles: null
    }
    commit(types.UPDATE_USER, { user })
  }
}

// mutations
const mutations = {
  [types.UPDATE_USER] (state, { user }) {
    state.user = user
  }
}

export default {
  state,
  getters,
  actions,
  mutations
}
