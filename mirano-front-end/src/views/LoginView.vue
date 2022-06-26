<template>
    <div class = "brand font-anybody text-center text-2xl text-blue mb-8">
        Mirano
    </div>
    <div class = "wrapper fixed w-[100%] h-[100vh] top-0"
        :style="'left: -'+(stage*100)+'%'">

        <div class = "stage  w-[100%] h-[100%] absolute left-[0%] p-6 pb-48">
           
        </div>

        <div class = "stage  w-[100%] h-[100%] absolute left-[100%] p-6 pb-48">
            <div class = "header relative text-center">
                <div class = "number bg-blue rounded-full p-4 inline-block relative">
                    <div class = "absolute-center text-white font-bold">2</div>
                </div>
                <br>
                <div class = "help font-bold text-2xl">
                    How much money will you send?
                </div>
            </div>

            <div class = "input mt-2 flex">
                <div class = "coin font-bold m-auto mr-2 text-2xl">USD</div>
                <input class = "bg-white rounded-xl p-2 w-[100%] shadow-sm text-right" type = "text" v-model="amount.value"/>
            </div>
            
            <div class = "input mt-4">
                <div class = "text-center mb-2">
                    What is it to be used for?
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
                    Check if everything is correct
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
    <div id="world-id-container"></div>
    <!-- <div class = "button bg-blue rounded-xl w-2/2 p-2 text-white text-center font-bold ml-2 cursor-pointer"
        @click="goNext()">
        <span>Login With Worldcoin</span>
    </div> -->
    <div class = "movement fixed bottom-0 left-0 w-[100%] p-6 shadow-lg bg-white">
        <div class = "inner flex">
            <div class = "button bg-blue rounded-xl w-1/2 p-2 text-white text-center font-bold mr-2 cursor-pointer"
                :class="{invisible: stage == 0}"
                @click="goPrevious()">
                ←Back
            </div>

        </div>
    </div>
</template>

<script>
    import axios from "axios";
    import {PrivyClient, CustomSession} from '@privy-io/privy-browser';
    import worldID from "@worldcoin/id";
    window.addEventListener("load", async function() {
        // here is the Vue code
        try
        {
            // eslint-disable-next-line no-unused-vars
            const result = await worldID.enable(); // <- Send 'result' to your backend or smart contract
            console.log("World ID verified successfully!");
        } catch (failure) {
            console.warn("World ID verification failed:", failure);
            // Re-activate here so your end user can try again
        }
    });
    export default {
        data: function() {
            return {
                // session: getSession(),
                stage: 0,
                address: "abcdefghijklmnopqrstuvwxyz",
                businessName: "",
                businessCategory: "0",
                businessCategories: [
                    { name: "Select a Category", value: "0" },
                    { name: "Groceries", value: "1" },
                    { name: "Pharmacies", value: "2" },
                    { name: "Hardware Stores", value: "3" },
                    { name: "Education", value: "4" },
                    { name: "Utilities", value: "5" },
                    ],
                businessAddress: null,
                businessEmail: null,
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
                        clothes: {
                            enabled: false,
                            amount: 0,
                            name: "Clothes"
                            },
                        videogames: {
                            enabled: false,
                            amount: 0,
                            name: "Videogames"
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
            startWorldId(){
                worldID.init("world-id-container", {
                    enable_telemetry: true,
                    action_id: "wid_BPZsRJANxct2cZxVRyh80SFG",
                    signal: "Sign Up",
                });
            },
            verifyWorldId(){
                const data = JSON.stringify({
                    "merkle_root": "0x1f38b57f3bdf96f05ea62fa68814871bf0ca8ce4dbe073d8497d5a6b0a53e5e0",
                    "nullifier_hash": "0x0339861e70a9bdb6b01a88c7534a3332db915d3d06511b79a5724221a6958fbe",
                    "action_id": "wid_staging_109245c713c4ac91457bc322f0a34537",
                    "signal": "Sign Up",
                    "proof": "0x063942fd7ea1616f17787d2e3374c1826ebcd2d41d2394d915098c73482fa59516145cee11d59158b4012a463f487725cb3331bf90a0472e17385832eeaec7a713164055fc43cc0f873d76752de0e35cc653346ec42232649d40f5b8ded28f202793c4e8d096493dc34b02ce4252785df207c2b76673924502ab56b7e844baf621025148173fc74682213753493e8c90e5c224fc43786fcd09b624115bee824618e57bd28caa301f6b21606e7dce789090de053e641bce2ce0999b64cdfdfb0a0734413914c21e4e858bf38085310d47cd4cc6570ed634faa2246728ad64c49f1f720a39530d82e1fae1532bd7ad389978b6f337fcd6fa6381869637596e63a1"
                });
                const config = {
                    method: "post",
                    url: "https://developer.worldcoin.org/api/v1/verify",
                    headers: { 
                        "Content-Type": "application/json"
                    },
                    data : data
                };
                axios.post(config);
            },
            async getSession(){
                const session = new CustomSession(async function authenticate() {
                    const response = await axios.post<{token: process.env.PRIVY_API_PUBLIC_KEY}>(process.env.PRIVY_API_URL);
                    return response.data.token;
                });
                const client = new PrivyClient({
                    session: session,
                });
                await this.setPrivyData(client);
                // return client;
            },
            async setPrivyData(client){
                let r = (Math.random() + 1).toString(36).substring(7);
                const businessId = r;
                // To write...
                // eslint-disable-next-line no-unused-vars
                const [name, category, email, address] = await client.put(businessId, [
                    {field: 'name', value: this.businessName},
                    {field: 'category', value: this.businessCategory},
                    {field: 'email', value: this.businessEmail},
                    {field: 'address', value: this.businessAddress},
                ]);
                console.log(name, category, address);
            },
            goNext() {
                switch(this.stage) {
                    case 0:
                        // Insert code to call privy
                        this.getSession();
                        break;

                    case 1:
                        break;

                    case 2:
                        break;

                    default:
                        break;
                    }
                // this.stage = Math.min(2,this.stage+1);
            },

            goPrevious() {
                this.stage = Math.max(0,this.stage-1);

            },

            toggleDivision(division) {
                division.enabled = !(division.enabled);
            }
        },
        mounted() {
            this.startWorldId();
        },
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