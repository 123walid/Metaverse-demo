const Land = artifacts.require("Land");

module.exports = async function (deployer) {
    const NAME="Metaverse"
    const SYMBOLE="META"
    const COST= web3.utils.toWei('1','ether')
    await deployer.deploy(Land,NAME,SYMBOLE,COST);
};
