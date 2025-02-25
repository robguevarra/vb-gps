import { Profile, DonationMap } from "@/types/reports";

export const formatNumber = (num: number, fractionDigits = 2) => {
  return num.toLocaleString(undefined, {
    minimumFractionDigits: fractionDigits,
    maximumFractionDigits: fractionDigits,
  });
};

export const getDonationForChurch = (
  chId: number,
  missionaries: Profile[],
  donationMap: DonationMap,
  year: number,
  month: number
) => {
  let total = 0;
  missionaries
    .filter((m) => m.local_church_id === chId)
    .forEach((m) => {
      const key = `${year}-${String(month + 1).padStart(2, "0")}`;
      total += donationMap[m.id]?.[key] || 0;
    });
  return total;
};

export const getChurchMonthlyGoal = (chId: number, missionaries: Profile[]) => {
  let sum = 0;
  missionaries
    .filter((m) => m.local_church_id === chId)
    .forEach((m) => {
      sum += m.monthly_goal || 0;
    });
  return sum;
};

export const getDonationForMissionary = (
  mId: string,
  donationMap: DonationMap,
  year: number,
  month: number
) => {
  const key = `${year}-${String(month + 1).padStart(2, "0")}`;
  return donationMap[mId]?.[key] || 0;
};

export const getCurrentMonthRatio = (m: Profile, donationMap: DonationMap) => {
  const now = new Date();
  const y = now.getFullYear();
  const mo = now.getMonth();
  const donated = getDonationForMissionary(m.id, donationMap, y, mo);
  const goal = m.monthly_goal || 0;
  if (goal === 0) return 0;
  return (donated / goal) * 100;
};

export const getLastXMonthsRatios = (m: Profile, donationMap: DonationMap, x: number) => {
  const out: { label: string; ratio: number }[] = [];
  let now = new Date();
  let y = now.getFullYear();
  let mo = now.getMonth();
  
  for (let i = 0; i < x; i++) {
    const label = `${y}-${String(mo + 1).padStart(2, "0")}`;
    const donated = getDonationForMissionary(m.id, donationMap, y, mo);
    const mg = m.monthly_goal || 0;
    const ratio = mg > 0 ? (donated / mg) * 100 : 0;
    out.push({ label, ratio });
    mo--;
    if (mo < 0) {
      mo = 11;
      y--;
    }
  }
  return out.reverse();
};

export const generateThirteenMonthKeys = () => {
  const keys: string[] = [];
  let now = new Date();
  let y = now.getFullYear();
  let mo = now.getMonth();
  
  for (let i = 0; i < 13; i++) {
    const key = `${y}-${String(mo + 1).padStart(2, "0")}`;
    keys.push(key);
    mo--;
    if (mo < 0) {
      mo = 11;
      y--;
    }
  }
  return keys.reverse();
};

export const getLastMonthKey = () => {
  const now = new Date();
  const lastMonth = new Date(now.getFullYear(), now.getMonth() - 1);
  return `${lastMonth.getFullYear()}-${String(lastMonth.getMonth() + 1).padStart(2, "0")}`;
}; 