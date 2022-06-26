import { defineStore } from 'pinia'

export const useGlobalStore = defineStore('global', {
      state: function() {
        return {
            name: "Hello World The Second"
            }
        },

    actions: {
        printName: function() {
            console.log(this.name);
            },
        }
    })