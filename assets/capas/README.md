# Assets — Capas (covers)

Capas dos álbuns das categorias **Infantis (cat 98)** e **Doxologia (cat 99)**,
usadas pelo desktop (campo `IMAGEM` da view `DOXOLOGIA_ALBUNS`, carregadas de
`dir_config + 'capas\'`) e servidas pela API em `/file/covers/<nome>.jpg`.

| Arquivo | Álbum (id) | Categoria |
|---|---|---|
| `jesus_criancas.jpg` | Infantis (9000), Adoração Infantil (9013) | Infantis |
| `pessoas.jpg` | Entrada da Plataforma (9010) | Doxologia |
| `dinheiro.jpg` | Dízimos e Ofertas (9011) | Doxologia |
| `oracao.jpg` | Oração Intercessora (9012) | Doxologia |
| `igreja.jpg` | Término de Culto (9014) | Doxologia |

Fonte: acervo pianolouvorja/api (`media/covers/`), espelhado automaticamente.
Catálogo: `pianolouvorja/api` → migrations `016_kids_doxology_catalog.sql` e
`017_kids_doxology_assets.sql`.
