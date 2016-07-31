package com.fallarm.database;

import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;

import com.fallarm.util.HibernateUtil;

public class PopupManager {

	public void insertPopup(String patient) {
		try {
			Session session = HibernateUtil.currentSession();
			Transaction t = session.beginTransaction();

			Query q = session.createQuery("select nurse_id from Person_information where pid='" + patient + "'");
			List l = q.list();
			Popup p = new Popup();
			p.setDatafrom(patient);
			p.setDatato((String) l.get(0));

			session.save(p);
			t.commit();
			HibernateUtil.closeSession();
		} catch (Exception e) {
			HibernateUtil.closeSession();
		}
	}

	public String getPopup(String userId) {
		try {
			Session session = HibernateUtil.currentSession();
			Transaction t = session.beginTransaction();
			Query q = session.createQuery("select datafrom from Popup where datato='" + userId + "'");
			List l = q.list();
			if (l.size() <= 0) {
				HibernateUtil.closeSession();
				return "";
			}
			String patient = (String) l.get(0);
			Popup p = new Popup();
			p.setDatafrom(patient);
			p.setDatato(userId);

			session.delete(p);

			t.commit();
			HibernateUtil.closeSession();
			return patient;
		} catch (Exception e) {
			HibernateUtil.closeSession();
			return "";
		}
	}
}