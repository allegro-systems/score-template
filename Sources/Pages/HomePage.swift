import Score
import ScoreLucide

struct HomePage: Page {
    static let path = "/"

    @Query(ItemsController.self) var items: [Item]
    @State var input = ItemForm()
    @State var editId = ""
    @State var editInput = ItemForm()

    @Action
    mutating func addItem() {
        items.create(["title": input.title, "description": input.description])
        input.reset()
    }

    @Action
    mutating func saveEdit() {
        items.update(editId, ["title": editInput.title, "description": editInput.description])
    }

    var body: some Node {
        Stack {
            Stack {
                // Header
                Header {
                    Link(to: "/") {
                        Text { "Score" }
                            .font(.sans, size: 16, weight: .semibold, color: .text)
                    }
                    LanguageDropdown(pagePath: Self.path)
                }
                .flex(.row, align: .center, justify: .spaceBetween)
                .padding(16, at: .vertical)

                // Hero + counter
                Section {
                    Heading(.one) { t("home.title") }
                        .font(.sans, size: 32, weight: .bold, color: .text, align: .center)
                        .animate(.fadeIn, duration: 0.6)

                    Paragraph { t("home.subtitle") }
                        .font(.mono, size: 13, color: .muted, align: .center)
                        .animate(.fadeIn, duration: 0.6, delay: 0.2)

                    Counter()
                }
                .flex(.column, gap: 16, align: .center)
                .padding(12, at: .vertical)

                // Asset example — files in Resources/ are processed by the
                // asset pipeline and served from /assets/ with fingerprinted
                // filenames for cache busting.
                Section {
                    Image(src: "/assets/example.png", alt: "Example asset", width: 120, height: 40)
                        .border(radius: 6)

                    Paragraph { "Files in Resources/ are fingerprinted and served from /assets/." }
                        .font(.mono, size: 11, color: .muted, align: .center)
                }
                .flex(.column, gap: 8, align: .center)
                .padding(12, at: .vertical)

                // Features — CRUD via @Query (local-first)
                Section {
                    Heading(.two) { t("api.title") }
                        .font(.sans, size: 20, weight: .semibold, color: .text)

                    Paragraph {
                        Text { t("api.description.before") }
                        Code { "/api/items" }
                            .font(.mono, size: 11, color: .accent)
                            .background(.surface)
                            .padding(4, at: .horizontal)
                            .padding(2, at: .vertical)
                            .border(radius: 4)
                        Text { t("api.description.after") }
                    }
                    .font(.mono, size: 12, color: .muted)

                    // Loading state
                    Paragraph { "Loading..." }
                        .font(.mono, size: 13, color: .muted)
                        .visible(when: $items.isLoading)

                    // Sync status
                    Paragraph { "Syncing..." }
                        .font(.mono, size: 11, color: .muted)
                        .visible(when: $items.isSyncing)

                    // Items grid — rendered by Signal.effect watching items signal
                    Stack {}
                        .htmlAttribute("id", "items-grid")
                        .grid(columns: 3, gap: 12)

                    // Add item form
                    Stack {
                        Input(type: .text, name: "title", placeholder: t("api.placeholder.title"), value: $input.title)
                            .font(.mono, size: 13, color: .text)
                            .padding(10)
                            .background(.surface)
                            .border(width: 1, color: .border, style: .solid, radius: 6)
                            .flex(grow: 1)

                        Input(type: .text, name: "description", placeholder: t("api.placeholder.description"), value: $input.description)
                            .font(.mono, size: 13, color: .text)
                            .padding(10)
                            .background(.surface)
                            .border(width: 1, color: .border, style: .solid, radius: 6)
                            .flex(grow: 1)

                        Button(type: .button) {
                            Icon("plus", size: 14, color: .text)
                            Text { t("api.add") }
                        }
                        .on(.click, action: "addItem")
                        .flex(.row, gap: 6, align: .center)
                        .font(.mono, size: 13, weight: .medium, color: .text)
                        .padding(10, at: .vertical)
                        .padding(16, at: .horizontal)
                        .background(.surface)
                        .border(width: 1, color: .border, style: .solid, radius: 6)
                        .cursor(.pointer)
                        .hover { $0.background(.elevated) }
                    }
                    .flex(.row, gap: 12, align: .center)

                    // Edit dialog
                    Dialog {
                        Stack {
                            Heading(.two) { t("api.edit.title") }
                                .font(.sans, size: 18, weight: .semibold, color: .text)

                            Input(type: .text, name: "edit-title", placeholder: t("api.placeholder.title"), value: $editInput.title)
                                .font(.mono, size: 13, color: .text)
                                .padding(10)
                                .background(.surface)
                                .border(width: 1, color: .border, style: .solid, radius: 6)

                            Input(type: .text, name: "edit-desc", placeholder: t("api.placeholder.description"), value: $editInput.description)
                                .font(.mono, size: 13, color: .text)
                                .padding(10)
                                .background(.surface)
                                .border(width: 1, color: .border, style: .solid, radius: 6)

                            Stack {
                                Button(type: .button) { t("api.cancel") }
                                    .htmlAttribute("id", "edit-cancel")
                                    .font(.mono, size: 13, color: .muted)
                                    .padding(8, at: .vertical)
                                    .padding(16, at: .horizontal)
                                    .background(.surface)
                                    .border(width: 1, color: .border, style: .solid, radius: 6)
                                    .cursor(.pointer)
                                    .hover { $0.background(.elevated) }

                                Button(type: .button) { t("api.save") }
                                    .htmlAttribute("id", "edit-save")
                                    .font(.mono, size: 13, weight: .medium, color: .text)
                                    .padding(8, at: .vertical)
                                    .padding(16, at: .horizontal)
                                    .background(.surface)
                                    .border(width: 1, color: .border, style: .solid, radius: 6)
                                    .cursor(.pointer)
                                    .hover { $0.background(.elevated) }
                            }
                            .flex(.row, gap: 8, justify: .end)
                        }
                        .flex(.column, gap: 16)
                    }
                    .htmlAttribute("id", "edit-dialog")
                    .padding(24)
                    .background(.surface)
                    .border(radius: 12)
                    .size(width: 360)

                    // SCORE-GAP: Dynamic list rendering from @Query signal array
                    // The @Query provides items signal + CRUD methods (items_create, items_update, items_delete).
                    // This script only handles rendering the grid from the signal — all CRUD is local-first.
                    RawTextNode(itemsRenderScript)
                }
                .flex(.column, gap: 16, align: .stretch)
                .padding(12, at: .vertical)
            }
            .flex(.column)
            .size(width: .percent(100), maxWidth: 720)
            .padding(24, at: .horizontal)
        }
        .flex(.column, align: .center)
    }
}

// SCORE-GAP: Dynamic list rendering from @Query signal
// Once Score supports reactive list rendering (e.g. data-list binding),
// this script can be removed entirely.
private let itemsRenderScript = """
    <style>
    .item-card{display:flex;flex-direction:column;gap:8px;padding:20px;background:var(--color-surface);border:1px solid var(--color-border);border-radius:8px}
    .item-title{font-family:var(--font-sans);font-size:14px;color:var(--color-text)}
    .item-desc{font-family:var(--font-mono);font-size:12px;color:var(--color-muted)}
    .item-actions{display:flex;gap:6px}
    .item-btn{font-family:var(--font-mono);font-size:11px;color:var(--color-muted);background:none;border:1px solid var(--color-border);border-radius:4px;padding:4px 8px;cursor:pointer}
    .item-empty{font-family:var(--font-mono);font-size:13px;color:var(--color-muted)}
    </style>
    <script>
    addEventListener('DOMContentLoaded', function(){
      var grid=document.getElementById('items-grid');
      var dialog=document.getElementById('edit-dialog');
      var saveBtn=document.getElementById('edit-save');
      var cancelBtn=document.getElementById('edit-cancel');

      Signal.effect(function(){
        var data=items.get();
        grid.innerHTML='';
        if(!data.length){
          grid.innerHTML='<p class="item-empty">No items yet. Add one above.</p>';
          return;
        }
        data.forEach(function(item){
          var card=document.createElement('div');
          card.className='item-card';
          var title=document.createElement('strong');
          title.className='item-title';
          title.textContent=item.title;
          var desc=document.createElement('span');
          desc.className='item-desc';
          desc.textContent=item.description;
          var btns=document.createElement('div');
          btns.className='item-actions';
          var editBtn=document.createElement('button');
          editBtn.className='item-btn';
          editBtn.textContent='Edit';
          editBtn.onclick=function(){
            editId.set(item.id);
            editInput_title.set(item.title);
            editInput_description.set(item.description);
            dialog.showModal();
          };
          var delBtn=document.createElement('button');
          delBtn.className='item-btn';
          delBtn.textContent='Delete';
          delBtn.onclick=function(){items_delete(item.id)};
          btns.appendChild(editBtn);
          btns.appendChild(delBtn);
          card.appendChild(title);
          card.appendChild(desc);
          card.appendChild(btns);
          grid.appendChild(card);
        });
      });

      saveBtn.addEventListener('click',function(){
        dialog.close();
        saveEdit();
      });
      cancelBtn.addEventListener('click',function(){dialog.close()});
    });
    </script>
    """
