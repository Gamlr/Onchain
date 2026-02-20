# Gamlr Onchain JS SDK

SDK JavaScript para qualquer jogo integrar com o contrato `GamlrOnchainRegistry`.

## Instalação

Copie `sdk/src` para o seu projeto, ou publique como pacote interno.

```bash
npm i ethers
```

## Campos cobertos (web2-inspo -> web3)

- avatar.png -> `avatarURI`
- Informações do jogador -> `playerSettingsURI`
- Pontuações -> `addScore`
- Conquistas -> `addAchievement`
- Missões -> `upsertMission`
- Pontos de experiência -> `addExperienceEvent`
- Atividade (primeira/última sessão) -> `activity` no contrato
- Imagem da capa -> `coverImageURI`
- dados.bin -> `dataURI` + `dataFormat`
- Metadados do save -> `metadataURI`
- nome.bin -> `nameDataURI` + `nameDataFormat`
- Sequências -> `setStreak`
- Tempo de jogo -> `setPlaytime`
- Contas vinculadas -> `addLinkedAccount`
- Seguindo -> `addFollowing`

## Uso rápido

Veja `sdk/examples/basic-usage.mjs`.
