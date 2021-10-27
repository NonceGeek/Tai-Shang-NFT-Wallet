// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

// import "./Whitelist.sol";

contract N is ERC721Enumerable, ReentrancyGuard, Ownable {
    uint8[] private units = [
        1,
        2,
        3,
        4,
        5,
        6,
        7,
        8,
        9,
        1,
        2,
        3,
        4,
        5,
        6,
        7,
        8,
        9,
        1,
        2,
        3,
        4,
        5,
        6,
        7,
        8,
        9,
        1,
        2,
        3,
        4,
        5,
        6,
        7,
        8,
        9,
        10
    ];
    uint8[] private multipliers = [
        1,
        1,
        1,
        1,
        1,
        1,
        1,
        1,
        1,
        1,
        1,
        1,
        1,
        1,
        1,
        1,
        1,
        1,
        1,
        1,
        1,
        1,
        1,
        1,
        1,
        1,
        1,
        1,
        1,
        1,
        1,
        1,
        1,
        1,
        1,
        1,
        1,
        1,
        1,
        1,
        1,
        1,
        1,
        1,
        1,
        1,
        1,
        1,
        1,
        1,
        1,
        1,
        1,
        1,
        1,
        1,
        1,
        1,
        1,
        1,
        1,
        1,
        1,
        1,
        1,
        1,
        1,
        1,
        1,
        1,
        1,
        1,
        1,
        1,
        1,
        1,
        1,
        1,
        1,
        1,
        1,
        1,
        1,
        1,
        1,
        1,
        1,
        0
    ];
    uint8[] private suffixes = [1, 2];
    address public admin;

    // Whitelist public whitelistContract;

    mapping(address => bool) isClaimed;

    struct AuthenticationInfo {
        address owner;
        string name;
        string info;
    }

    /// @dev tokenId => chapter => Story
    mapping(uint256 => mapping(uint256 => AuthenticationInfo))
        private _authenticationInfos;

    mapping(uint256 => uint256) public chapter;
    mapping(uint256 => bool) public isSuper;

    constructor() ERC721("n", "N") Ownable() {
        // whitelistContract = Whitelist(whitelistContractAddr);
        admin = _msgSender();
    }

    // constructor(address whitelistContractAddr) ERC721("n", "N") Ownable() {
    //     whitelistContract = Whitelist(whitelistContractAddr);
    //     admin = _msgSender();
    // }

    function random(string memory input) internal pure returns (uint256) {
        return uint256(keccak256(abi.encodePacked(input)));
    }

    function getFirst(uint256 tokenId) public view returns (uint256) {
        return pluck(tokenId, "FIRST", units);
    }

    function getSecond(uint256 tokenId) public view returns (uint256) {
        return pluck(tokenId, "SECOND", units);
    }

    function getThird(uint256 tokenId) public view returns (uint256) {
        return pluck(tokenId, "THIRD", units);
    }

    function getFourth(uint256 tokenId) public view returns (uint256) {
        return pluck(tokenId, "FOURTH", units);
    }

    function getFifth(uint256 tokenId) public view returns (uint256) {
        return pluck(tokenId, "FIFTH", units);
    }

    function getSixth(uint256 tokenId) public view returns (uint256) {
        return pluck(tokenId, "SIXTH", units);
    }

    function getSeventh(uint256 tokenId) public view returns (uint256) {
        return pluck(tokenId, "SEVENT", units);
    }

    function getEight(uint256 tokenId) public view returns (uint256) {
        return pluck(tokenId, "EIGHT", units);
    }

    function pluck(
        uint256 tokenId,
        string memory keyPrefix,
        uint8[] memory sourceArray
    ) internal view returns (uint256) {
        uint256 rand = random(
            string(abi.encodePacked(keyPrefix, toString(tokenId)))
        );
        uint256 output = sourceArray[rand % sourceArray.length];
        uint256 luck = rand % 21;
        if (luck > 14) {
            output += suffixes[rand % suffixes.length];
        }
        if (luck >= 19) {
            if (luck == 19) {
                output =
                    (output * multipliers[rand % multipliers.length]) +
                    suffixes[rand % suffixes.length];
            } else {
                output = (output * multipliers[rand % multipliers.length]);
            }
        }
        return output;
    }

    function claimAuthenticationInfo(
        uint256 tokenId,
        string memory name,
        string memory info
    ) public {
        require(_msgSender() == admin, "No permission");
        isSuper[tokenId] = true;
        AuthenticationInfo memory _authenticationInfo;
        _authenticationInfo.owner = ownerOf(tokenId);
        _authenticationInfo.name = name;
        _authenticationInfo.info = info;
        chapter[tokenId] = chapter[tokenId] + 1;
        _authenticationInfos[tokenId][chapter[tokenId]] = _authenticationInfo;
    }

    function cancelClaimAuthenticationInfo(uint256 tokenId) public {
        require(_msgSender() == admin, "No permission");
        isSuper[tokenId] = false;
    }

    function toString(uint256 value) internal pure returns (string memory) {
        // Inspired by OraclizeAPI's implementation - MIT license
        // https://github.com/oraclize/ethereum-api/blob/b42146b063c7d6ee1358846c198246239e9360e8/oraclizeAPI_0.4.25.sol

        if (value == 0) {
            return "0";
        }
        uint256 temp = value;
        uint256 digits;
        while (temp != 0) {
            digits++;
            temp /= 10;
        }
        bytes memory buffer = new bytes(digits);
        while (value != 0) {
            digits -= 1;
            buffer[digits] = bytes1(uint8(48 + uint256(value % 10)));
            value /= 10;
        }
        return string(buffer);
    }

    function claim(uint256 tokenId) public nonReentrant {
        require(tokenId > 0 && tokenId < 8889, "Token ID invalid");
        // require(
        //     whitelistContract.isMember(_msgSender()),
        //     "You are not in the whitelist"
        // );
        require(isClaimed[_msgSender()] == false, "You have already claimed");
        _safeMint(_msgSender(), tokenId);
        isClaimed[_msgSender()] = true;
    }

    function tokenURI(uint256 tokenId)
        public
        view
        override
        returns (string memory)
    {
        if (isSuper[tokenId]) {
            return _superTokenURI(tokenId);
        } else {
            return _commonTokenURI(tokenId);
        }
    }

    function _commonTokenURI(uint256 tokenId)
        internal
        view
        returns (string memory)
    {
        string[17] memory parts;
        parts[
            0
        ] = '<svg xmlns="http://www.w3.org/2000/svg" preserveAspectRatio="xMinYMin meet" viewBox="0 0 350 350"><style>.base { fill: white; font-family: serif; font-size: 14px; }</style><rect width="100%" height="100%" fill="black" /><text x="10" y="20" class="base">';

        parts[1] = toString(getFirst(tokenId));

        parts[2] = '</text><text x="10" y="40" class="base">';

        parts[3] = toString(getSecond(tokenId));

        parts[4] = '</text><text x="10" y="60" class="base">';

        parts[5] = toString(getThird(tokenId));

        parts[6] = '</text><text x="10" y="80" class="base">';

        parts[7] = toString(getFourth(tokenId));

        parts[8] = '</text><text x="10" y="100" class="base">';

        parts[9] = toString(getFifth(tokenId));

        parts[10] = '</text><text x="10" y="120" class="base">';

        parts[11] = toString(getSixth(tokenId));

        parts[12] = '</text><text x="10" y="140" class="base">';

        parts[13] = toString(getSeventh(tokenId));

        parts[14] = '</text><text x="10" y="160" class="base">';

        parts[15] = toString(getEight(tokenId));

        parts[16] = "</text></svg>";

        string memory output = string(
            abi.encodePacked(
                parts[0],
                parts[1],
                parts[2],
                parts[3],
                parts[4],
                parts[5],
                parts[6],
                parts[7],
                parts[8]
            )
        );
        output = string(
            abi.encodePacked(
                output,
                parts[9],
                parts[10],
                parts[11],
                parts[12],
                parts[13],
                parts[14],
                parts[15],
                parts[16]
            )
        );

        string memory json = Base64.encode(
            bytes(
                string(
                    abi.encodePacked(
                        '{"name": "N #',
                        toString(tokenId),
                        '", "description": "N is just numbers.", "image": "data:image/svg+xml;base64,',
                        Base64.encode(bytes(output)),
                        '"}'
                    )
                )
            )
        );
        output = string(
            abi.encodePacked("data:application/json;base64,", json)
        );

        return output;
    }

    function _superTokenURI(uint256 tokenId)
        internal
        view
        returns (string memory)
    {
        string[24] memory parts;
        parts[
            0
        ] = '<svg xmlns="http://www.w3.org/2000/svg" preserveAspectRatio="xMinYMin meet" viewBox="0 0 350 350"><style>.base { fill: white; font-family: serif; font-size: 14px; }.content{line-height:1.2;animation: moveUp 8s 0s infinite;position:relative;color: #fff;}.box{overflow: hidden;height: 150px;}@keyframes moveUp{0% {top:100%;} 100% {top:-100%; display: none;}}</style><rect width="100%" height="100%" fill="black" /><text x="10" y="20" class="base">';

        parts[1] = toString(getFirst(tokenId));

        parts[2] = '</text><text x="10" y="40" class="base">';

        parts[3] = toString(getSecond(tokenId));

        parts[4] = '</text><text x="10" y="60" class="base">';

        parts[5] = toString(getThird(tokenId));

        parts[6] = '</text><text x="10" y="80" class="base">';

        parts[7] = toString(getFourth(tokenId));

        parts[8] = '</text><text x="10" y="100" class="base">';

        parts[9] = toString(getFifth(tokenId));

        parts[10] = '</text><text x="10" y="120" class="base">';

        parts[11] = toString(getSixth(tokenId));

        parts[12] = '</text><text x="10" y="140" class="base">';

        parts[13] = toString(getSeventh(tokenId));

        parts[14] = '</text><text x="10" y="160" class="base">';

        parts[15] = toString(getEight(tokenId));

        parts[16] = '</text><text x="10" y="180" class="base">Name:';

        parts[17] = _authenticationInfos[tokenId][chapter[tokenId]].name;

        parts[
            18
        ] = '</text><text x="10" y="200" class="base">Authentication information:';
        parts[19] = "";
        parts[20] = " : ";
        parts[
            21
        ] = '</text><foreignObject width="320" height="510" x="10" y="210"><body xmlns="http://www.w3.org/1999/xhtml"><div class="box"><p class="content">';
        parts[22] = _authenticationInfos[tokenId][chapter[tokenId]].info;

        parts[23] = "</p></div></body></foreignObject></svg>";

        string memory output = string(
            abi.encodePacked(
                parts[0],
                parts[1],
                parts[2],
                parts[3],
                parts[4],
                parts[5],
                parts[6],
                parts[7],
                parts[8]
            )
        );
        output = string(
            abi.encodePacked(
                output,
                parts[9],
                parts[10],
                parts[11],
                parts[12],
                parts[13],
                parts[14],
                parts[15],
                parts[16]
            )
        );
        output = string(
            abi.encodePacked(
                output,
                parts[17],
                parts[18],
                parts[19],
                parts[20],
                parts[21],
                parts[22],
                parts[23]
            )
        );

        string memory json = Base64.encode(
            bytes(
                string(
                    abi.encodePacked(
                        '{"name": "superN #',
                        toString(tokenId),
                        '", "description": "superN is just numbers.", "image": "data:image/svg+xml;base64,',
                        Base64.encode(bytes(output)),
                        '"}'
                    )
                )
            )
        );
        output = string(
            abi.encodePacked("data:application/json;base64,", json)
        );

        return output;
    }
}

/// [MIT License]
/// @title Base64
/// @notice Provides a function for encoding some bytes in base64
/// @author Brecht Devos <brecht@loopring.org>
library Base64 {
    bytes internal constant TABLE =
        "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";

    /// @notice Encodes some bytes to the base64 representation
    function encode(bytes memory data) internal pure returns (string memory) {
        uint256 len = data.length;
        if (len == 0) return "";

        // multiply by 4/3 rounded up
        uint256 encodedLen = 4 * ((len + 2) / 3);

        // Add some extra buffer at the end
        bytes memory result = new bytes(encodedLen + 32);

        bytes memory table = TABLE;

        assembly {
            let tablePtr := add(table, 1)
            let resultPtr := add(result, 32)

            for {
                let i := 0
            } lt(i, len) {

            } {
                i := add(i, 3)
                let input := and(mload(add(data, i)), 0xffffff)

                let out := mload(add(tablePtr, and(shr(18, input), 0x3F)))
                out := shl(8, out)
                out := add(
                    out,
                    and(mload(add(tablePtr, and(shr(12, input), 0x3F))), 0xFF)
                )
                out := shl(8, out)
                out := add(
                    out,
                    and(mload(add(tablePtr, and(shr(6, input), 0x3F))), 0xFF)
                )
                out := shl(8, out)
                out := add(
                    out,
                    and(mload(add(tablePtr, and(input, 0x3F))), 0xFF)
                )
                out := shl(224, out)

                mstore(resultPtr, out)

                resultPtr := add(resultPtr, 4)
            }

            switch mod(len, 3)
            case 1 {
                mstore(sub(resultPtr, 2), shl(240, 0x3d3d))
            }
            case 2 {
                mstore(sub(resultPtr, 1), shl(248, 0x3d))
            }

            mstore(result, encodedLen)
        }

        return string(result);
    }
}
