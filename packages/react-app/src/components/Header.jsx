import { PageHeader } from "antd";
import React from "react";

// displays a page header

export default function Header() {
  return (
    <a href="https://github.com/leeduckgo/bewater-nft-wallet" target="_blank" rel="noopener noreferrer">
      <PageHeader
        title="BeWater"
        subTitle="🖼 NFT Wallet0x01"
        style={{ cursor: "pointer" }}
      />
    </a>
  );
}
