package com.fallarm.database;

import java.math.BigInteger;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import java.util.Locale;

import org.hibernate.Query;
import org.hibernate.SQLQuery;
import org.hibernate.Session;
import org.hibernate.Transaction;

import com.fallarm.util.HibernateUtil;

public class DeviceManager {

	public void insertDeviceData(Device_data data) {
		try {
			Session session = HibernateUtil.currentSession();

			Transaction t = session.beginTransaction();
			session.save(data);
			t.commit();

			HibernateUtil.closeSession();
		} catch (Exception e) {
			System.out.println("Exception in insertDeviceData:" + e.getMessage() + " Parameter=" + data.toString());
		}
	}

	public Device_data[] listDetails(String userId, int offset, int limit) {
		try {
			Session session = HibernateUtil.currentSession();
			Transaction t = session.beginTransaction();

			SQLQuery q1 = session.createSQLQuery("select * from Device_data d where d.pid='" + userId
					+ "' or d.pid in (select pid from person_information where nurse_id='" + userId
					+ "') order by d.pid,d.time desc");
			q1.setFirstResult(offset);
			q1.setMaxResults(limit);
			q1.addEntity(Device_data.class);
			List<Device_data> l = q1.list();
			Device_data d[] = new Device_data[l.size()];
			int i = 0;
			for (Iterator iterator = l.iterator(); iterator.hasNext();) {
				d[i] = (Device_data) iterator.next();
				i++;
			}

			t.commit();
			HibernateUtil.closeSession();

			return d;
		} catch (Exception e) {
			System.out.println("Exception in listDetails:" + e.getMessage() + " Parameters=" + userId + "," + offset
					+ "," + limit);
			return null;
		}
	}

	public Device_data[] listDetailsSearch(String userId, int offset, int limit, String sdate, String edate) {
		try {
			Session session = HibernateUtil.currentSession();
			Transaction t = session.beginTransaction();

			DateFormat originalFormat = new SimpleDateFormat("MM/dd/yyyy", Locale.ENGLISH);
			DateFormat targetFormat = new SimpleDateFormat("dd/MM/yyyy");
			Date startdate = null;
			Date enddate = null;
			try {
				startdate = originalFormat.parse(sdate);
				enddate = originalFormat.parse(edate);
			} catch (ParseException e) {
				HibernateUtil.closeSession();
			}
			String sDate = targetFormat.format(startdate);
			String eDate = targetFormat.format(enddate) + " 23:59:59.999";

			SQLQuery q1 = session.createSQLQuery("select * from Device_data d where d.pid='" + userId
					+ "' and time between '" + sDate + "' and '" + eDate + "' order by d.time desc");
			q1.setFirstResult(offset);
			q1.setMaxResults(limit);
			q1.addEntity(Device_data.class);
			List<Device_data> l = q1.list();
			Device_data d[] = new Device_data[l.size()];
			int i = 0;
			for (Iterator iterator = l.iterator(); iterator.hasNext();) {
				d[i] = (Device_data) iterator.next();
				i++;
			}

			t.commit();
			HibernateUtil.closeSession();

			return d;
		} catch (Exception e) {
			System.out.println("Exception in listDetailsSearch:" + e.getMessage() + " Parameters=" + userId + ","
					+ offset + "," + limit + "," + sdate + "," + edate);
			return null;
		}
	}

	public BigInteger listDetailsCountSearch(String userId, String sdate, String edate) {
		try {
			Session session = HibernateUtil.currentSession();

			Transaction t = session.beginTransaction();

			DateFormat originalFormat = new SimpleDateFormat("MM/dd/yyyy", Locale.ENGLISH);
			DateFormat targetFormat = new SimpleDateFormat("dd/MM/yyyy");
			Date startdate = null;
			Date enddate = null;
			try {
				startdate = originalFormat.parse(sdate);
				enddate = originalFormat.parse(edate);
			} catch (ParseException e) {
				HibernateUtil.closeSession();
			}
			String sDate = targetFormat.format(startdate);
			String eDate = targetFormat.format(enddate) + " 23:59:59.999";

			SQLQuery q = session.createSQLQuery("select count(*) from Device_data d where d.pid='" + userId
					+ "' and time between '" + sDate + "' and '" + eDate + "'");
			BigInteger count = (BigInteger) q.uniqueResult();

			t.commit();
			HibernateUtil.closeSession();

			return count;
		} catch (Exception e) {
			System.out.println("Exception in listDetailsCountSearch:" + e.getMessage() + " Parameters=" + userId + ","
					+ sdate + "," + edate);
			return null;
		}
	}

	public BigInteger countData(String userId) {
		try {
			Session session = HibernateUtil.currentSession();

			Transaction t = session.beginTransaction();
			SQLQuery q = session.createSQLQuery("select count(*) from Device_data d where d.pid='" + userId
					+ "' or d.pid in (select pid from person_information where nurse_id='" + userId + "')");
			BigInteger count = (BigInteger) q.uniqueResult();

			t.commit();
			HibernateUtil.closeSession();

			return count;
		} catch (Exception e) {
			System.out.println("Exception in countData:" + e.getMessage() + " Parameters=" + userId);
			return null;
		}
	}

	public void addComments(String id, String date, String comments) {
		try {
			Session session = HibernateUtil.currentSession();
			Transaction t = session.beginTransaction();

			Query q = session.createQuery("update Device_data SET comments='" + comments + "' where pid='" + id
					+ "' and time='" + date + "'");
			q.executeUpdate();

			t.commit();
			HibernateUtil.closeSession();
		} catch (Exception e) {
			HibernateUtil.closeSession();
			System.out.println(
					"Exception in addComments:" + e.getMessage() + " Parameters=" + id + "," + date + "," + comments);
		}
	}

}
