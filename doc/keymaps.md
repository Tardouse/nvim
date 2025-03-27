# Keymap

## Global keymap
| Key   | Mode   | Action                                 | description            |
| ---   | ---    | ---                                    | ---                    |
| <Esc> | Normal | `<cmd>nohlsearch<CR>`                  | Clear search highlight |
| \\p   | Normal | `:lua print(vim.fn.expand('%:p'))<CR>` | Print full path        |
| <C-t> | Noraml | `:NEDTreeToggle<CR>`                   | Toggle NERDTree        |
| "tp"  | Normal | `:bprevious<CR>`                       | Switch to previous buf |
| "tn"  | Normal | `:bnext<CR>`                           | Switch to next buf     |
| "td"  | Normal | `:bd<CR>`                              | Close current buf      |


## Specific Plugin keymap 

### AutoCompletion
| Key   | Mode   | Action | description |
| ---   | ---    | ---    | ---         |
| <C-f> | Insert | -      | close cmp   |
| <C-o> | Insert | -      | open cmp    |

### vim-commentary
| Key | Mode   | Action | description               |
| --- | ---    | ---    | ---                       |
| gc  | Normal | -      | Toggle comment            |
| gcc | Normal | -      | Toggle comment out a line |

### copilot
| Key   | Mode   | Action | description           |
| ---   | ---    | ---    | ---                   |
| <Tab> | Noraml |        | accept the suggestion |

### debugger
| Key       | Mode   | Action | description             |
| ---       | ---    | ---    | ---                     |
| <leader>os      | Normal | -      | Start/Continue          |
| <leader>ok      | Normal | -      | Step Into               |
| <leader>oj      | Normal | -      | Step Over               |
| <leader>ol      | Normal | -      | Step Out                |
| <leader>ob      | Normal | -      | Toggle Breakpoint       |
| <leader>oB      | Normal | -      | Set Breakpoint          |
| <leader>op      | Normal | -      | See last session result |

### editor
| Key | Mode   | Action | description    |
| --- | ---    | ---    | ---            |
| za  | Normal | -      | Toggle fold    |
| zc  | Normal | -      | Close fold     |
| zo  | Normal | -      | Open fold      |
| zM  | Normal | -      | Close all fold |
| zR  | Normal | -      | Open all fold  |

### fun
| Key        | Mode | Action | description       |
| ---        | ---  | ---    | ---               |
| <leader>rr | -    | -      | display rain code |

### fzf
| Key   | Mode   | Action | description                       |
| ---   | ---    | ---    | ---                               |
| <C-f> | Normal | -      | fzf contents                      |
| <C-f> | Visual | -      | fzf contents via visual selection |

builtin keymap:
| Key      | Mode | Action | description         |
| ---      | ---  | ---    | ---                 |
| <c-f>    | -    | -      | toggle-fullscreen   |
| <c-r>    | -    | -      | toggle-preview-wrap |
| <c-p>    | -    | -      | toggle-preview      |
| <c-n>    | -    | -      | preview-page-down   |
| <c-u>    | -    | -      | preview-page-up     |
| <S-left> | -    | -      | preview-page-reset  |
| esc      | -    | -      | abort               |
| ctrl-j   | -    | -      | down                |
| ctrl-k   | -    | -      | up                  |

### git
| Key        | Mode | Action | description |
| ---        | ---  | ---    | ---         |
| <leader>lz | -    | -      | lazygit     |
| <leader>gp | -    | -      | prev_hunk   |
| <leader>gn | -    | -      | next_hunk   |
| <leader>gr | -    | -      | reset_hunk  |
| <leader>gb | -    | -      | blame_line  |

### lsp
| Key       | Mode   | Action | description          |
| ---       | ---    | ---    | ---                  |
| <leader>hd| Normal | -      | show documentation   |
| <c-l>     | Normal | -      | go to definition     |
| <leader>hl| Normal | -      | go to implementation  |
| <leader>hL| Normal | -      | go to type definition |
| <leader>hr| Normal | -      | show references      |
| <c-f>     | Insert | -      | show signature help  |
| <leader>rn| Normal | -      | rename symbol        |
| <leader>aw| Normal | -      | code action menu     |
| <leader>ht| Normal | -      | toggle trouble       |
| <leader>- | Normal | -      | goto prev diagnostic |
| <leader>= | Normal | -      | goto next diagnostic |

### markdown
| Key        | Mode   | Action | description          |
| ---        | ---    | ---    | ---                  |
| <leader>mp | Normal | -      | toggle markdown view |
| <leader>mt | Normal | -      | toggle table mode    |
| <leader>mg | Normal | -      | generate toc         |
| <leader>mc | Normal | -      | update toc           |

### vim-visual-multi
| Key   | Mode   | Action | description |
| ---   | ---    | ---    | ---         |
| <C-n> | Normal | -      | start multi |
| <C-n> | Visual | -      | start multi |

### ranger
| Key   | Mode   | Action | description   |
| ---   | ---    | ---    | ---           |
| <M-o> | Normal | -      | toggle ranger |

builtin keymap:
| Key   | Mode | Action | description                 |
| ---   | ---  | ---    | ---                         |
| <C-t> | -    | -      | open in tab                 |
| <C-x> | -    | -      | open in split               |
| <C-v> | -    | -      | open in vsplit              |
| gw    | -    | -      | jump to cwd                 |
| yw    | -    | -      | emit ranger cwd and jump it |


### nvim-surround
| Key | Mode   | Action | description |
| --- | ---    | ---    | ---         |
| ys  | Normal | -      | surround    |
| cs  | Normal | -      | change      |
| ds  | Normal | -      | delete      |
| S   | Visual | -      | surround    |

### telescope
| Key        | Mode   | Action | description          |
| ---        | ---    | ---    | ---                  |
| <leader>tf | Normal | -      | find files           |
| <leader>rs | Normal | -      | resume               |
| <leader>tb | Normal | -      | buffers              |
| <leader>to | Normal | -      | oldfiles             |
| <leader>tz | Normal | -      | current_buffer_fuzzy |
| <leader>ts | Normal | -      | spell_suggest        |
| <leader>td | Normal | -      | diagnostics          |
| <leader>tg | Normal | -      | git_status           |
| <leader>t. | Normal | -      | commands             |


### tex


### toggle-bool
| Key       | Mode   | Action | description |
| ---       | ---    | ---    | ---         |
| <leader>s | Normal | -      | toggle bool |


### translate
| Key        | Mode          | Action | description      |
| ---        | ---           | ---    | ---              |
| <leader>sw | Normal/Visual | -      | translate word   |
| <leader>sr | Normal/Visual | -      | translate region |


### Undo
| Key | Mode   | Action | description |
| --- | ---    | ---    | ---         |
| tu  | Normal | -      | undo tree   |


### winbar
| ---       | ---    | ---    | ---         |
| Key       | Mode   | Action | description |
| <leader>; | Normal | -      | pick        |


### window-management
| Key       | Mode   | Action | description |
| ---       | ---    | ---    | ---         |
| <leader>f | Normal | -      | toggle zoom |


### yank
| Key       | Mode   | Action | description |
| ---       | ---    | ---    | ---         |
| <leader>y | Normal | `:Telescope neoclip<CR>`      | neoclip     |


