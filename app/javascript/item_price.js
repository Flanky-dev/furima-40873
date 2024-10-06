const price = () => {
  const priceInput = document.getElementById("item-price");
  const addTaxDom = document.getElementById("add-tax-price");
  const profitDom = document.getElementById("profit");

  if (priceInput) {
    priceInput.addEventListener("input", () => {
      const inputValue = priceInput.value;

      // 販売手数料の計算（10%）
      const tax = Math.floor(inputValue * 0.1);
      addTaxDom.innerHTML = tax;

      // 販売利益の計算
      const profit = Math.floor(inputValue - tax);
      profitDom.innerHTML = profit;
    });
  }
};

document.addEventListener('DOMContentLoaded', price);
window.addEventListener("turbo:load", price);
window.addEventListener("turbo:render", price);