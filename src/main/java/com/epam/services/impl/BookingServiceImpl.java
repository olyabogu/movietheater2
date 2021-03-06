package com.epam.services.impl;

import com.epam.dao.BookingDao;
import com.epam.domain.Discount;
import com.epam.domain.Event;
import com.epam.domain.Rating;
import com.epam.domain.Ticket;
import com.epam.domain.User;
import com.epam.domain.UserAccount;
import com.epam.exception.MovieException;
import com.epam.services.BookingService;
import com.epam.services.DiscountService;
import com.epam.services.UserAccountService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.Calendar;
import java.util.Date;
import java.util.LinkedList;
import java.util.List;

@Service
public class BookingServiceImpl implements BookingService {
	@Autowired
	private DiscountService discountService;
	@Autowired
	private BookingDao bookingDao;
	@Autowired
	private UserAccountService accountService;

	/**
	 * @return Price for ticket for specified event
	 * on specific date and for specified seats.
	 */
	public Double getTicketPrice(Event event, Date date, boolean isVipSeats, User user) {
		Double price = event.getBasePrice();
		Discount discount = calculateDiscount(date, user);
		if (isVipSeats) {
			price *= 2;
		}
		if (Rating.HIGH.equals(event.getRating())) {
			price *= 1.2;
		}
		if (discount != null) {
			price *= discount.getDiscountStrategy().getPercent() / 100;
		}
		return price;
	}

	@Transactional(propagation = Propagation.REQUIRES_NEW)
	public boolean bookTicket(User user, Ticket ticket) {
		UserAccount account = user.getAccount();
		Double balance = account.getAmount();
		if (ticket.getPrice() > balance) {
			throw new MovieException("Operation could not be completed since not enough money on user balance!");
		}
		int ticketId = bookingDao.create(ticket);
		ticket.setId(ticketId);

		Double newBalance = balance - ticket.getPrice();
		account.setAmount(newBalance);
		accountService.update(account);

		return true;
	}

	/**
	 * Get all purchased tickets for event for specific date
	 */
	public List<Ticket> getTicketsForEvent(Event event, Date date) {
		List<Ticket> tickets = event.getTickets();
		List<Ticket> purchasedTickets = new LinkedList<>();
		for (Ticket ticket : tickets) {
			if (ticket.isPurchased()) {
				purchasedTickets.add(ticket);
			}
		}
		return purchasedTickets;
	}

	private Discount calculateDiscount(Date date, User user) {

		Calendar calendarForEventDate = Calendar.getInstance();
		calendarForEventDate.setTime(date);

		Calendar calendarForUserBirthday = Calendar.getInstance();
		calendarForUserBirthday.setTime(user.getBirthDate());

		boolean sameMonth = calendarForEventDate.get(Calendar.MONTH) == calendarForUserBirthday.get(Calendar.MONTH);
		boolean sameDay = calendarForEventDate.get(Calendar.DAY_OF_MONTH) == calendarForUserBirthday.get(Calendar.DAY_OF_MONTH);
		boolean isTodayUserBirthday = sameDay && sameMonth;

		return discountService.getDiscount(user, isTodayUserBirthday);
	}
}
