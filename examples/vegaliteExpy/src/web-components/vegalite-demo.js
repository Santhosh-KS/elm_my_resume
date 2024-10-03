import embed from "vega-embed";
import * as vl from "vega-lite-api";

class VegaliteComponent extends HTMLElement {
  constructor() {
    super();
    this._spec = "";
    this._path = "";
  }
  connectedCallback() {
    console.log("connectedCallback");
    this.render();
    this.imdbDataRender();
  }

  get spec() {
    return this._spec;
  }

  get path() {
    return this._csvPath;
  }

  set spec(nv) {
    if (this._spec === nv) return;
    console.log("NEW SPEC VALUE: ", nv);
    this._spec = nv.url;
  }

  set path(nv) {
    if (this._path === nv) return;
    console.log("NEW CSV VALUE: ", nv);
    this._path = nv.path;
  }

  render() {
    var spec = this._spec;
    // "https://raw.githubusercontent.com/vega/vega/master/docs/examples/bar-chart.vg.json";
    console.log("OLD SPEC: ", spec);
    // console.log("VL: ", vl);
    embed("#vis", spec)
      .then(function (result) {
        console.log(result);
      })
      .catch(console.error);
    embed("#vis1", spec)
      .then(function (result) {
        console.log(result);
      })
      .catch(console.error);
  }

  testData() {
    v = {
      $schema: "https://vega.github.io/schema/vega/v5.json",
      width: 400,
      height: 200,
      padding: 5,

      data: [
        {
          name: "table",
          values: [
            { category: "A", amount: 28 },
            { category: "B", amount: 55 },
            { category: "C", amount: 43 },
            { category: "D", amount: 91 },
            { category: "E", amount: 81 },
            { category: "F", amount: 53 },
            { category: "G", amount: 19 },
            { category: "H", amount: 87 },
          ],
        },
      ],

      signals: [
        {
          name: "tooltip",
          value: {},
          on: [
            { events: "rect:mouseover", update: "datum" },
            { events: "rect:mouseout", update: "{}" },
          ],
        },
      ],

      scales: [
        {
          name: "xscale",
          type: "band",
          domain: { data: "table", field: "category" },
          range: "width",
          padding: 0.05,
          round: true,
        },
        {
          name: "yscale",
          domain: { data: "table", field: "amount" },
          nice: true,
          range: "height",
        },
      ],

      axes: [
        { orient: "bottom", scale: "xscale" },
        { orient: "left", scale: "yscale" },
      ],

      marks: [
        {
          type: "rect",
          from: { data: "table" },
          encode: {
            enter: {
              x: { scale: "xscale", field: "category" },
              width: { scale: "xscale", band: 1 },
              y: { scale: "yscale", field: "amount" },
              y2: { scale: "yscale", value: 0 },
            },
            update: {
              fill: { value: "steelblue" },
            },
            hover: {
              fill: { value: "red" },
            },
          },
        },
        {
          type: "text",
          encode: {
            enter: {
              align: { value: "center" },
              baseline: { value: "bottom" },
              fill: { value: "#333" },
            },
            update: {
              x: { scale: "xscale", signal: "tooltip.category", band: 0.5 },
              y: { scale: "yscale", signal: "tooltip.amount", offset: -2 },
              text: { signal: "tooltip.amount" },
              fillOpacity: [
                { test: "isNaN(tooltip.amount)", value: 0 },
                { value: 1 },
              ],
            },
          },
        },
      ],
    };
    return v;
  }

  imdbDataRender() {
    // console.log("MYNAME IS PATH:", this._path);
    // var tmpData = vl.data(this._path);
    // console.log("TMP DATA: ", tmpData);
    var a = vl
      .markBar()
      .data(this._path)
      .encode(vl.x().fieldQ("IMDB_Rating").bin(true), vl.y().count());
    // .toObject();
    // .render();
    /* .then((viewElement) => {
        document.getElementById("imdbDisp").appendChild(viewElement);
      }); */

    console.log("HELLO Details: ", a);
    var b = vl
      .markCircle()
      .data(
        // provide inline CSV data!
        // vl.csv().values(this._path),
        vl.csv().values("a,b,c\n1,2,3\n4,5,6\n7,8,9\n6,5,4\n3,2,1"),
      )
      .encode(
        vl.x().fieldQ("a").axis({ tickMinStep: 1 }),
        vl.y().fieldQ("b").axis({ tickMinStep: 1 }),
        vl.size().fieldQ("c").legend({ titleAnchor: "middle" }),
      )
      .toObject();

    // console.log("IMDB A SPEC: ", a);
    // embed("#imdbDisp", a)
    embed("#imdbDisp", b)
      .then(function (result) {})
      .catch(console.error);
  }
}

window.customElements.define("vega-demo", VegaliteComponent);
