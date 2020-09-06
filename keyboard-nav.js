(function() {
  const VK_LEFT  = 37;
  const VK_UP    = 38;
  const VK_RIGHT = 39;
  const VK_DOWN  = 40;
  const VI_LEFT  = 72;
  const VI_UP    = 75;
  const VI_RIGHT = 76;
  const VI_DOWN  = 74;

  class anchorGroup extends HTMLElement {
    constructor() {
      super();
    }
    connectedCallback() {
      this.anchors = Array.from(this.querySelectorAll('a'));
      if (this.hasAttribute('selected')) {
        let selected = this.getAttribute('selected');
        this._selected = parseInt(selected);
        this.anchors[selected].tabIndex = 0;
        this.anchors[selected].setAttribute('aria-checked', true);
        this.anchors[selected].focus();
      }
      this.addEventListener('keydown', this.handleKeyDown.bind(this));
      this.addEventListener('Domcontentloaded', this.setAttribute('selected', 0));
    }
    handleKeyDown(e) {
      let parent = this.parentElement;
      let focus = document.getSelection().focusNode;
      let direction = "";
      let columns = window.matchMedia('(min-width: 1000px)').matches ? 7 :
        window.matchMedia('(min-width: 900px)').matches ? 6 :
        window.matchMedia('(min-width: 800px)').matches ? 5 :
        window.matchMedia('(min-width: 700px)').matches ? 4 :
        window.matchMedia('(min-width: 600px)').matches ? 3 : 2;
        switch(e.keyCode) {
        case VI_UP:
        case VK_UP: {
          e.preventDefault();
          if (this._selected < columns) {
            this.selected = this.anchors.length - 1;
          } else {
            this.selected = this.selected - columns;
            direction = "backward";
          }
          break;
        }
        case VI_LEFT:
        case VK_LEFT: {
          e.preventDefault();
          if (this._selected === 0) {
            this.selected = this.anchors.length - 1;
          } else {
            this.selected = this._selected - 1;
            direction = "backward";
          }
          break;
        }
        case VI_RIGHT:
        case VK_RIGHT: {
          e.preventDefault();
          if (this._selected === this.anchors.length - 1) {
            this.selected = 0;
          } else {
            this.selected = this._selected + 1;
            direction = "forward";
          }
          break;
        }
        case VI_DOWN:
        case VK_DOWN: {
          e.preventDefault();
          if (this._selected >= this.anchors.length - columns) {
            this.selected = 0;
          } else {
            this.selected = this._selected + columns;
            direction = "forward";
          }
          break;
        }
      }
      switch(direction) {
        case "forward": {
          focus.scrollIntoView({behavior: "smooth", block: "start", inline: "nearest"});
          break;
        }
        case "backward": {
          focus.scrollIntoView({behavior: "smooth", block: "end", inline: "nearest"});
          break;
        }
      }
    }
    set selected(idx) {
      if (isFinite(this.selected)) {
        // Set the old button to tabindex -1
        let previousSelected = this.anchors[this.selected];
        previousSelected.tabIndex = -1;
        previousSelected.setAttribute('aria-checked', false);
      }
      // Set the new button to tabindex 0 and focus it
      idx = parseInt(idx);
      let newSelected = this.anchors[idx];
      newSelected.tabIndex = 0;
      newSelected.focus();
      newSelected.setAttribute('aria-checked', true);
      this.setAttribute('selected', idx);
      this._selected = idx;
    }
    get selected() {
      return this._selected;
    }
  }
  window.customElements.define('anchor-group', anchorGroup);
})();
