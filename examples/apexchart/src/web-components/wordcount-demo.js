class WordCount extends HTMLElement {
  constructor() {
    super();

    const shadow = this.attachShadow({ mode: "open" });
    const text = document.createElement("div");
    text.className = "title";
    text.textContent = "Hello world";
    shadow.appendChild(text);
  }
}

customElements.define("word-count", WordCount);
