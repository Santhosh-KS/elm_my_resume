import ApexCharts from "apexcharts";

class ApexChartComponent extends HTMLElement {
  constructor() {
    super();
    // this.inputdata = [10, 41, 35, 51, 49, 62, 69, 91, 148];
    this._data = [1, 2];
  }

  get data() {
    return this._data;
  }

  set data(nv) {
    if (nv === this._data) return;
    this._data = nv.data;
  }
  /* static get observedAttributes() {
    return [`inputdata`];
  }

  get inputdata() {
    return this.inputdata;
  }

  set inputdata(val) {
    return this.setAttribute(`inputdata`, val);
  } */

  connectedCallback() {
    this.render(this._data);
  }

  get data() {
    this._data;
  }
  set data(nv) {
    if (nv.data === this._data) return;
    this._data = nv.data;
  }

  render(data) {
    var options = {
      series: [
        {
          name: "Desktops",
          // data: [10, 41, 35, 51, 49, 62, 69, 91, 148],
          data: data,
        },
      ],
      chart: {
        height: 350,
        type: "line",
        zoom: {
          enabled: false,
        },
      },
      dataLabels: {
        enabled: false,
      },
      stroke: {
        curve: "straight",
      },
      title: {
        text: "Product Trends by Month",
        align: "left",
      },
      grid: {
        row: {
          colors: ["#f3f3f3", "transparent"], // takes an array which will be repeated on columns
          opacity: 0.5,
        },
      },
      xaxis: {
        categories: [
          "Jan",
          "Feb",
          "Mar",
          "Apr",
          "May",
          "Jun",
          "Jul",
          "Aug",
          "Sep",
        ],
      },
    };

    var chart = new ApexCharts(document.querySelector("#chart"), options);
    chart.render();
  }
}

export default class ApexMultiChartComponent extends HTMLElement {
  constructor() {
    super();
  }

  connectedCallback() {
    this.minMaxRender();
  }

  minMaxRender() {
    var options = {
      series: [
        {
          name: "Income",
          type: "column",
          data: [1.4, 2, 2.5, 1.5, 2.5, 2.8, 3.8, 4.6],
        },
        {
          name: "Cashflow",
          type: "column",
          data: [1.1, 3, 3.1, 4, 4.1, 4.9, 6.5, 8.5],
        },
        {
          name: "Revenue",
          type: "line",
          data: [20, 29, 37, 36, 44, 45, 50, 58],
        },
      ],
      chart: {
        height: 350,
        type: "line",
        stacked: false,
      },
      dataLabels: {
        enabled: false,
      },
      stroke: {
        width: [1, 1, 4],
      },
      title: {
        text: "XYZ - Stock Analysis (2009 - 2016)",
        align: "left",
        offsetX: 110,
      },
      xaxis: {
        categories: [2009, 2010, 2011, 2012, 2013, 2014, 2015, 2016],
      },
      yaxis: [
        {
          seriesName: "Income",
          axisTicks: {
            show: true,
          },
          axisBorder: {
            show: true,
            color: "#008FFB",
          },
          labels: {
            style: {
              colors: "#008FFB",
            },
          },
          title: {
            text: "Income (thousand crores)",
            style: {
              color: "#008FFB",
            },
          },
          tooltip: {
            enabled: true,
          },
        },
        {
          seriesName: "Cashflow",
          opposite: true,
          axisTicks: {
            show: true,
          },
          axisBorder: {
            show: true,
            color: "#00E396",
          },
          labels: {
            style: {
              colors: "#00E396",
            },
          },
          title: {
            text: "Operating Cashflow (thousand crores)",
            style: {
              color: "#00E396",
            },
          },
        },
        {
          seriesName: "Revenue",
          opposite: true,
          axisTicks: {
            show: true,
          },
          axisBorder: {
            show: true,
            color: "#FEB019",
          },
          labels: {
            style: {
              colors: "#FEB019",
            },
          },
          title: {
            text: "Revenue (thousand crores)",
            style: {
              color: "#FEB019",
            },
          },
        },
      ],
      tooltip: {
        fixed: {
          enabled: true,
          position: "topLeft", // topRight, topLeft, bottomRight, bottomLeft
          offsetY: 30,
          offsetX: 60,
        },
      },
      legend: {
        horizontalAlign: "left",
        offsetX: 40,
      },
    };

    var chart = new ApexCharts(document.querySelector("#multichart"), options);
    chart.render();
  }
}

window.customElements.define("chart-demo", ApexChartComponent);
window.customElements.define("multi-chart-demo", ApexMultiChartComponent);
