import { buildModule } from "@nomicfoundation/hardhat-ignition/modules";

const MarkretPlaceModule = buildModule("ProposalVoteModule", (m) => {
  const Marketplace = m.contract("Marketplace");

  return { Marketplace };
});

export default MarkretPlaceModule;