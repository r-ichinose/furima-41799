const price = () => {
  const priceInput = document.getElementById("item-price");
  const addTaxDom = document.getElementById("add-tax-price");
  const profitDom = document.getElementById("profit");

  if (priceInput) {
    priceInput.addEventListener("input", () => {
      const inputValue = priceInput.value;
      const price = parseInt(inputValue);
      
      if (isNaN(price)) {
        return;
      }
      
      const salesCommission = Math.floor(price * 0.1);
      const salesProfit = Math.floor(price - salesCommission);
      
      addTaxDom.innerHTML = `${salesCommission.toLocaleString()}`;
      profitDom.innerHTML = `${salesProfit.toLocaleString()}`;
    });
  }
};

window.addEventListener("turbo:load", price);
window.addEventListener("turbo:render", price);
