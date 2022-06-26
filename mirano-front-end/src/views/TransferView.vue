<template>
    <div class = "wrapper fixed w-[100%] h-[100vh] top-0"
        :style="'left: -'+(stage*100)+'%'">

        <div class = "stage  w-[100%] h-[100%] absolute left-[0%] p-6 pb-48">
            <div class = "back">
                <router-link to="/" class = "p-2 text-2xl font-bold">←</router-link>
            </div>

            <div class = "header relative text-center">
                <div class = "number bg-blue rounded-full p-4 inline-block relative">
                    <div class = "absolute-center text-white font-bold">1</div>
                </div>
                <br>
                <div class = "help font-bold text-2xl">
                    Send money
                </div>
            </div>

            <div class = "input mt-2">
                <div class = "text-center mb-2">
                    Wallet address:
                </div>
                <input class = "bg-white rounded-xl p-2 w-[100%] shadow-sm" type = "text" v-model="address" placeholder="e.g.: 0xACa94ef8bD5ffEE41947b4585a84BdA5a3d3DA6E"/>
            </div>
        </div>

        <div class = "stage  w-[100%] h-[100%] absolute left-[100%] p-6 pb-48">
            <div class = "header relative text-center">
                <div class = "number bg-blue rounded-full p-4 inline-block relative">
                    <div class = "absolute-center text-white font-bold">2</div>
                </div>
                <br>
                <div class = "help font-bold text-2xl">
                    Enter an Amount
                </div>
            </div>

            <div class = "input mt-2 flex">
                <div class = "coin font-bold m-auto mr-2 text-2xl">USD</div>
                <input class = "bg-white rounded-xl p-2 w-[100%] shadow-sm text-right" type = "text" v-model="amount.value"/>
            </div>
            
            <div class = "input mt-4">
                <div class = "text-center mb-2">
                    How would you like this money to be used?
                </div>
                <div class = "group flex mt-2" v-for="division in amount.division" :key="division">
                    <div class = "checkbox w-10 h-10 m-auto rounded-xl shadow-md relative cursor-pointer"
                        :class="{'bg-blue': division.enabled, 'bg-white': !division.enabled}"
                        @click="toggleDivision(division)">

                        <div class = "check rounded-full bg-white absolute-center w-4 h-4" v-if="division.enabled">
                        </div>
                    </div>

                    <div class = "card w-[100%] bg-white rounded-xl shadow-sm p-2 pl-4 ml-2 flex"
                        :class="{'opacity-30': !division.enabled}">
                        <div class = "input w-[100%]">
                            <div class = "label mb-1">
                                {{division.name}}
                            </div>
                            <input class = "bg-[#DFE3F0] rounded-xl p-1 w-[100%] shadow-sm text-right" type = "text" v-model="division.amount"
                                :disabled="!division.enabled"/>
                        </div>
                        <div class = "percent mt-auto font-bold text-2xl text-right ml-2">
                            <span v-if="amount.value == 0">0%</span>
                            <span v-else>
                                {{Math.round(division.amount/amount.value*100)}}%
                            </span>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class = "stage  w-[100%] h-[100%] absolute left-[200%] p-6 pb-48">
            <div class = "header relative text-center">
                <div class = "number bg-blue rounded-full p-4 inline-block relative">
                    <div class = "absolute-center text-white font-bold">3</div>
                </div>
                <br>
                <div class = "help font-bold text-2xl">
                    Please confirm the details of your payment
                </div>
            </div>

            <div class = "input bg-white rounded-xl p-2">
                <div class = "mb-2">
                    <div class = "label text-sm">To:</div>{{address}}
                </div>
                <div class = "mb-2">
                    <div class = "label text-sm">Amount:</div>{{amount.value}}
                </div>
            </div>
        </div>
    </div>

    <div class = "movement fixed bottom-0 left-0 w-[100%] p-6 shadow-lg bg-white">
        <div class = "inner flex">
            <div class = "button bg-blue rounded-xl w-1/2 p-2 text-white text-center font-bold mr-2 cursor-pointer"
                :class="{invisible: stage == 0}"
                @click="goPrevious()">
                ←Back
            </div>
            <div class = "button bg-blue rounded-xl w-1/2 p-2 text-white text-center font-bold ml-2 cursor-pointer"
                @click="goNext()">
                <span v-if="stage<'1'">Next→</span>
                <span v-if="stage=='1'">Review</span>
                <span v-if="stage=='2'">Send</span> 
            </div>
        </div>
    </div>
</template>

<script>
    // eslint-disable-next-line no-unused-vars
    import Web3 from "web3";
    export default {
        data: function() {
            return {
                stage: 0,
                address: "",
                owner: {
                    name: ""
                    },
                amount: {
                    value: 0,
                    division: {
                        groceries: {
                            enabled: false,
                            amount: 0,
                            name: "Groceries"
                            },
                        pharmacies: {
                            enabled: false,
                            amount: 0,
                            name: "Pharmacies"
                            },
                        restaurants: {
                            enabled: false,
                            amount: 0,
                            name: "Restaurants"
                            },
                        hardware: {
                            enabled: false,
                            amount: 0,
                            name: "Hardware Stores"
                            },
                        unrestricted: {
                            enabled: false,
                            amount: 0,
                            name: "No restrictions"
                            }
                        }
                    }
            }
        },

        methods: {
            goNext() {
                switch(this.stage) {
                    case 0:
                        break;

                    case 1:
                        break;

                    case 2:
                        break;

                    default:
                        break;
                    }
                this.stage = Math.min(2,this.stage+1);
            },

            goPrevious() {
                this.stage = Math.max(0,this.stage-1);

            },

            toggleDivision(division) {
                division.enabled = !(division.enabled);
            }
        }
    };
</script>

<style>
.wrapper {
    transition: left .2s;    
}

.absolute-center {
    position: absolute;
    left: 50%;
    top: 50%;
    transform: translate(-50%,-50%);
}
</style>