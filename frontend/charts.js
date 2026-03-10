function createNoiseChart(data) {

  const labels = Object.keys(data);
  const values = Object.values(data);

  new Chart(document.getElementById("noiseChart"), {
    type: "bar",
    data: {
      labels: labels,
      datasets: [{
        label: "Average Noise Level (dB)",
        data: values,
        backgroundColor: "rgba(54,162,235,0.6)"
      }]
    }
  });

}