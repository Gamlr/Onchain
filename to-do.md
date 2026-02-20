# To-do

- [ ] XMTP para chat player-player, com abordagem segura e compliant.
- [ ] Definir e implementar experiências anti-cheating e anti-bot.
- [ ] Criar algo tipo um Live/GPlay Board, mas com Onchain as-a-service (incluindo smart contracts customizados, além de só oferecer escrita/leitura de contratos existentes).
- [ ] Desenvolver cartuchos de jogo NFTados com selo "Licensed for: GOC" (começando pelo MegaPRB).

## Estudos (aprofundar)

- [ ] Aprofundar estudo sobre XMTP aplicado a chat entre players com foco em segurança, compliance e moderação.
- [ ] Aprofundar estudo em estratégias anti-cheating/anti-bot para jogos onchain e híbridos.
- [ ] Aprofundar estudo sobre arquitetura de Onchain as-a-service para experiências estilo Live/GPlay Board com smart contracts customizados.
- [ ] Aprofundar estudo sobre design, licenciamento e implicações técnicas/comerciais de cartuchos NFTados com selo "Licensed for: GOC".
# To-Do: Web3 + Web2 Integrations for Gamlr Onchain Interactivity / Registry / Ostentation

## 0. Priority legend
- **P0:** unblock core architecture
- **P1:** high-value product capability
- **P2:** polish / growth / experimentation

---

## 1) Core registry architecture (P0)
- [ ] Define canonical IDs:
  - `gameId` format (bytes32 slug hash + human-readable metadata)
  - `playerId` format (wallet + optional DID + platform links)
- [ ] Finalize onchain schema for package pointers:
  - package digest
  - storage URI type (`ipfs://`, `ar://`, txHash ref)
  - timestamp, sequence, and chainId
- [ ] Add per-player monotonic sequence requirement to prevent replay-order ambiguity.
- [ ] Add game-version compatibility fields for deterministic replay.
- [ ] Implement optional merkle batching for many micro-packages.

## 2) `.tar.xz` reproducible replay pipeline (P0)
- [ ] Define deterministic serialization spec (`manifest.json` + event ordering + floating-point policy).
- [ ] Build SDK function: `createReplayPackage(sessionSlice) -> tar.xz + hashes`.
- [ ] Add signature flow:
  - player signs package hash
  - game server signs attestation (if server-authoritative)
- [ ] Add verification CLI: `verify-replay-package`.
- [ ] Add replay runner: `replay --from-package <cid>`.

## 3) Storage strategy (P0/P1)
- [ ] Implement IPFS upload path with pinning strategy (at least 2 pin providers).
- [ ] Implement Arweave fallback/parallel path for permanence.
- [ ] Add health monitor for dead or unpinned CIDs.
- [ ] Define retention tiers:
  - hot replays (7–30 days frequent access)
  - cold archive (long term)
- [ ] Add periodic Ethereum L1 root anchoring for L2 commitments.

## 4) Web2 integrations that actually matter (P1)
- [ ] Xbox Live adapter (policy-safe):
  - account linking (without making Xbox identity canonical)
  - achievements mirror (where allowed)
- [ ] Discord integration:
  - verifiable match summaries
  - replay links with signature badges
- [ ] Twitch/YouTube clip pipeline from deterministic replay timelines.
- [ ] Steam/EGS profile badge API bridge (offchain attestation if direct integration is restricted).
- [ ] Email/social login + wallet abstraction for normie onboarding.

## 5) Anti-cheat + transparency layer (P1)
- [ ] Publish anti-cheat evidence model (what gets logged, why, and limits).
- [ ] Add zero-knowledge friendly commitment hooks for future private proofs.
- [ ] Add referee dashboard:
  - suspicious-session diffing
  - package integrity checks
  - deterministic replay mismatch alerts
- [ ] Define appeals process and moderation SLA.

## 6) Ostentation / social flex features (P1/P2)
- [ ] Player profile timeline with verifiable milestones.
- [ ] "Proof of Play" cards generated from signed replay stats.
- [ ] Onchain season badges (soulbound optional mode).
- [ ] Team/clan registry with multisig-managed metadata.
- [ ] Public hall-of-fame contract/events feed.

## 7) Economics + cost controls (P1)
- [ ] Add adaptive commit policy:
  - high frequency during ranked matches
  - lower frequency during casual play
- [ ] Batch commits per match/round to reduce gas overhead.
- [ ] Model cost/user for peak concurrency scenarios.
- [ ] Add sponsorship/subsidy policy for onboarding users.

## 8) Privacy + legal hardening (P0)
- [ ] Data classification matrix (public, restricted, sensitive).
- [ ] Encrypt sensitive offchain payloads; keep only hashes onchain.
- [ ] Build consent UX with granular replay/data toggles.
- [ ] Add region-aware policy controls (GDPR/LGPD readiness).
- [ ] Mapear compliance de proteção infantojuvenil para experiências sociais/play-to-earn:
  - COPPA (EUA) + ECA (Brasil) com requisitos de idade, consentimento e moderação.
  - Definir se Plasmmer Accounts precisam ter modo "teen-safe" obrigatório por padrão.
  - Tratar KYC mínimo/atestado etário sem expor PII onchain.
- [ ] Definir regras de segurança para um "Habbo Web3" (PHIland/box hoje, Habbo-like amanhã):
  - filtros anti-grooming, anti-scam e anti-rug em chats/salas/marketplaces.
  - limites para transações entre menores e contas recém-criadas.
  - trilha de auditoria para mods com provas verificáveis sem vigilância abusiva.
- [ ] Draft incident response for data abuse and false-cheat accusations.

## 9) DevEx + ecosystem adoption (P2)
- [ ] Release SDKs (TS first, then Rust/Unity/C# bindings).
- [ ] Publish replay package spec v0.1 with test vectors.
- [ ] Provide reference game integration (minimal sample game).
- [ ] Launch indexer/subgraph for analytics and discovery.
- [ ] Create docs + migration guides for existing Web2 games.

## 10) Suggested implementation order
1. P0 schema + deterministic package spec
2. end-to-end package->storage->onchain pointer pipeline
3. verification + replay runner
4. privacy/legal guardrails
5. Web2 adapters (Discord first, then Xbox-like ecosystems)
6. social flex + growth surfaces

---

## Nice-to-have experiments
- [ ] ZK compression of event streams for low-cost integrity proofs.
- [ ] Real-time spectator mode backed by signed incremental package deltas.
- [ ] Cross-game reputation graph from verifiable play history.
- [ ] Explorar arquitetura de cloud gaming + blockchain (Stadia-like sem lock-in):
  - separar plano de render/stream (GPU edge) do plano de confiança (settlement/attestation).
  - comparar papéis de OMG Network, EigenCloud, Golem e Tensor/TAO para compute, disponibilidade e verificação econômica.
  - modelar latência, anti-cheat e custo por sessão para não matar UX com "descentralização cosplay".
