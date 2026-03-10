async function loadData() {

  const baseUrl = window.location.hostname === 'localhost' || window.location.hostname === '127.0.0.1' ? 'http://localhost:3000' : 'https://my-haskell-backend.onrender.com';
  const response = await fetch(`${baseUrl}/noise/average`);

  const data = await response.json();

  createNoiseChart(data);

}

loadData();