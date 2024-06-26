local human_readable_diff_translations = {
  justnow = "just now",
  minute = { singular = "a minute ago", plural = "minutes ago" },
  hour = { singular = "an hour ago", plural = "hours ago" },
  day = { singular = "a day ago", plural = "days ago" },
  week = { singular = "a week ago", plural = "weeks ago" },
  month = { singular = "a month ago", plural = "months ago" },
  year = { singular = "a year ago", plural = "years ago" },
}

local function round(num) return math.floor(num + 0.5) end

local M = {}

-- Returns a string representing the time difference between the given time and now
--
-- Tweaked from and is subject to LGPL-2.1:
-- https://github.com/f-person/lua-timeago
--
---@param time integer In `os.time()` format
---@return string
function M.human_readable_diff(time)
  local t = human_readable_diff_translations

  local now = os.time()
  local diff_seconds = os.difftime(now, time)
  if diff_seconds < 45 then return t.justnow end

  local diff_minutes = diff_seconds / 60
  if diff_minutes < 1.5 then return t.minute.singular end
  if diff_minutes < 59.5 then
    return round(diff_minutes) .. " " .. t.minute.plural
  end

  local diff_hours = diff_minutes / 60
  if diff_hours < 1.5 then return t.hour.singular end
  if diff_hours < 23.5 then return round(diff_hours) .. " " .. t.hour.plural end

  local diff_days = diff_hours / 24
  if diff_days < 1.5 then return t.day.singular end
  if diff_days < 6.5 then return round(diff_days) .. " " .. t.day.plural end

  local diff_weeks = diff_days / 7
  if diff_weeks < 1.5 then return t.week.singular end
  if diff_weeks < 4.2 then return round(diff_weeks) .. " " .. t.week.plural end

  local diff_months = diff_days / 30
  if diff_months < 1.5 then return t.month.singular end
  if diff_months < 11.5 then
    return round(diff_months) .. " " .. t.month.plural
  end

  local diff_years = diff_days / 365.25
  if diff_years < 1.5 then return t.year.singular end
  return round(diff_years) .. " " .. t.year.plural
end

return M
