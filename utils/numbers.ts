export function formatNumber(num: number, fractionDigits = 2) {
  return num.toLocaleString(undefined, {
    minimumFractionDigits: fractionDigits,
    maximumFractionDigits: fractionDigits,
  });
} 