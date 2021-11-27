export default async function SingleNFT({ nftGetQuery, readContracts, address }) {
  const tokenId = await readContracts.N.tokenOfOwnerByIndex(address, nftGetQuery);
  const tokenURI = await readContracts.N.tokenURI(tokenId);
  const svg = tokenURI.svg;

  return svg;
}
