<template>
    <div class = "brand font-anybody text-center text-2xl text-blue mb-8">
        Mirano
    </div>

    <div class = "balance text-center">
        <div class = "label">
            Account balance
            <img src="../assets/wallet_connect.png" v-on:click="connectWallet" />
        </div>
        <div class = "number-eth font-roboto text-4xl">
            ETH {{balance.eth}}
        </div>
        <div class = "number-usd">
            (USD {{balance.usd}})
        </div>
    </div>

    <div class = "actions flex mt-8 h-48">
        <div class = "side w-1/2 bg-blue mr-2 rounded-xl flex p-2 relative">
            <div class = "text text-white font-bold m-auto">
                Send money
            </div>
            <router-link to="/transfer" class = "absolute-fit"></router-link>
        </div>
        <div class = "side w-1/2 ml-2 flex flex-col">
            <div class = "bg-blue rounded-xl h-1/2 mb-2 flex">
                <div class = "text text-white font-bold m-auto">
                    Deposit
                </div>
            </div>
            <div class = "bg-blue rounded-xl h-1/2 mt-2 flex">
                <div class = "text text-white font-bold m-auto">
                    Withdraw
                </div>
            </div>
        </div>
    </div>

    <div class = "history mt-8">
        <div class = "label text-center mb-4">
            History
        </div>

        <div v-for="transaction in transactions" :key="transaction" class = "bg-white rounded-xl p-4 flex mb-4">
            <div class = "description flex-auto">
                <div class = "date">
                    {{transaction.date}}
                </div>
                <div class = "text text-sm">
                    {{transaction.text}}
                </div>
            </div>

            <div class = "amount text-right font-roboto text-xl w-1/8">
                {{transaction.amount}}
            </div>
        </div>
    </div>
</template>

<script>
    export default {
        data: function() {
            return {
                balance: {
                    eth: 0.00081,
                    usd: 500
                    },
                transactions: [
                    {
                    date: "06/01/2022",
                    amount: "-200.00",
                    text: "Sent to Robert."
                    },
                    {
                    date: "05/01/2022",
                    amount: "-50.00",
                    text: "Sent to Saúl."
                    },
                    {
                    date: "06/01/2022",
                    amount: "-100.00",
                    text: "Sent to Steph."
                    },
                    {
                    date: "05/01/2022",
                    amount: "-25.00",
                    text: "Sent to André."
                    }
                ]
            }
        },
        methods: {
            connectWallet () {
                this.$router.push("/connect-wallet");
            }
        },
    };
</script>

<style>
</style>