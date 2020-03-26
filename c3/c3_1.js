var chart1 = c3.generate({
  bindto: '#chart1',
  data: {
    columns: [
      ['data1', 30, 200, 100, 400, 150, 250],
      ['data2', 50, 20, 10, 40, 15, 25]
    ]
  }
});

var chart4_3 = c3.generate({
  bindto: '#chart4_3',
  data: {
    columns: [
      ['data1', 30, 200, 100, 400, 150, 250],
      ['data2', 50, 20, 10, 40, 15, 25],
      ['data3', 20, 70, 340, 80, 250, 50]
    ]
  }
});


function example4_3_1() {

    chart4_3.show(['data2', 'data3']);
}
function example4_3_2() {
    chart4_3.hide(['data2', 'data3']);
}
